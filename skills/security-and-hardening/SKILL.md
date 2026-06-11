---
name: security-and-hardening
description: "Hardens code against vulnerabilities. Use when handling user input, authentication, data storage, or external integrations. Use when building any feature that accepts untrusted data, manages user sessions, or interacts with third-party services."
triggers:
  - "security"
  - "hardening"
  - "vulnerability"
  - "auth"
  - "CORS"
  - "XSS"
  - "SQL injection"
  - "input validation"
  - "secrets"
  - "OWASP"
---

# Security and Hardening

## Why This Matters

Security is not a phase. It's a constraint on every line that touches user data, authentication, or external systems. Most breaches are not zero-days — they're basic failures: unvalidated input, unparameterized queries, secrets in code, endpoints without authorization checks. This skill is a checklist for not making the mistakes that automated scanners and basic attackers find first.

## When to Apply

- Building anything that accepts user input
- Implementing authentication or authorization
- Storing or transmitting sensitive data
- Integrating with external APIs or services
- Adding file uploads, webhooks, or callbacks
- Handling payment or PII data

---

## Threat Model First

Controls bolted on without a threat model are guesses. Before hardening, spend five minutes thinking like an attacker:

### 1. Map Trust Boundaries

Where does untrusted data cross into your system?

```
HTTP requests → form fields → file uploads → webhooks
Third-party APIs → message queues → LLM output
```

Every boundary is attack surface.

### 2. Name the Assets

What's worth stealing or breaking?

```
Credentials → PII → payment data → admin actions → money movement
```

### 3. Run a Quick STRIDE

| Threat | Question | Mitigation |
|---|---|---|
| Spoofing | Can someone impersonate a user/service? | Auth, signature verification |
| Tampering | Can data be altered? | Parameterized queries, HTTPS, integrity checks |
| Repudiation | Can an action be denied? | Audit logging |
| Information disclosure | Can data leak? | Encryption, field allowlists, generic errors |
| Denial of service | Can it be overwhelmed? | Rate limiting, input size caps, timeouts |
| Elevation of privilege | Can a user gain unauthorized rights? | Authorization checks, least privilege |

### 4. Write Abuse Cases

For each feature: "How would I misuse this?" — then make that your first test.

If you can't name the trust boundaries, you're not ready to secure it. OWASP A04: Insecure Design — most breaches begin in design, not code.

---

## Prevention Patterns

### Injection (SQL, NoSQL, OS Command)

```typescript
// BAD
const query = `SELECT * FROM users WHERE id = '${userId}'`;

// GOOD — parameterized
const user = await db.query('SELECT * FROM users WHERE id = $1', [userId]);

// GOOD — ORM
const user = await prisma.user.findUnique({ where: { id: userId } });
```

### Authentication & Sessions

```typescript
import { hash, compare } from 'bcrypt';

const SALT_ROUNDS = 12;
const hashed = await hash(plaintext, SALT_ROUNDS);
const valid = await compare(plaintext, hashed);

app.use(session({
  secret: process.env.SESSION_SECRET, // env, not code
  resave: false,
  saveUninitialized: false,
  cookie: {
    httpOnly: true,
    secure: true,
    sameSite: 'lax',
    maxAge: 24 * 60 * 60 * 1000,
  },
}));
```

### Access Control — Always Check Ownership

```typescript
app.patch('/api/tasks/:id', authenticate, async (req, res) => {
  const task = await taskService.findById(req.params.id);

  // Check ownership — not just auth
  if (task.ownerId !== req.user.id) {
    return res.status(403).json({
      error: { code: 'FORBIDDEN', message: 'Not authorized' }
    });
  }

  const updated = await taskService.update(req.params.id, req.body);
  return res.json(updated);
});
```

### Security Headers

```typescript
import helmet from 'helmet';
app.use(helmet());

app.use(helmet.contentSecurityPolicy({
  directives: {
    defaultSrc: ["'self'"],
    scriptSrc: ["'self'"],
    styleSrc: ["'self'", "'unsafe-inline'"],
    imgSrc: ["'self'", 'data:', 'https:'],
    connectSrc: ["'self'"],
  },
}));

// CORS — restrict to known origins
app.use(cors({
  origin: process.env.ALLOWED_ORIGINS?.split(',') || 'http://localhost:3000',
  credentials: true,
}));
```

### SSRF Protection

Any time the server fetches a URL the user controls — webhooks, image proxies, link previews — an attacker can aim it at internal services.

```typescript
import { lookup } from 'node:dns/promises';
import ipaddr from 'ipaddr.js';

const ALLOWED_HOSTS = new Set(['hooks.example.com']);

async function assertSafeUrl(raw: string): Promise<URL> {
  const url = new URL(raw);
  if (url.protocol !== 'https:') throw new Error('https only');
  if (!ALLOWED_HOSTS.has(url.hostname)) throw new Error('host not allowed');
  // Resolve ALL records; a single private/reserved address fails
  const addrs = await lookup(url.hostname, { all: true });
  if (addrs.some((a) => ipaddr.parse(a.address).range() !== 'unicast')) {
    throw new Error('private/reserved IP');
  }
  return url;
}

await fetch(await assertSafeUrl(req.body.webhookUrl), { redirect: 'error' });
```

### Input Validation at Boundaries

```typescript
import { z } from 'zod';

const CreateTaskSchema = z.object({
  title: z.string().min(1).max(200).trim(),
  description: z.string().max(2000).optional(),
  priority: z.enum(['low', 'medium', 'high']).default('medium'),
  dueDate: z.string().datetime().optional(),
});

app.post('/api/tasks', async (req, res) => {
  const result = CreateTaskSchema.safeParse(req.body);
  if (!result.success) {
    return res.status(422).json({
      error: { code: 'VALIDATION_ERROR', message: 'Invalid input',
        details: result.error.flatten() }
    });
  }
  const task = await taskService.create(result.data);
  return res.status(201).json(task);
});
```

### File Upload Safety

```typescript
const ALLOWED_TYPES = ['image/jpeg', 'image/png', 'image/webp'];
const MAX_SIZE = 5 * 1024 * 1024; // 5MB

function validateUpload(file: UploadedFile) {
  if (!ALLOWED_TYPES.includes(file.mimetype))
    throw new ValidationError('File type not allowed');
  if (file.size > MAX_SIZE)
    throw new ValidationError('File too large (max 5MB)');
}
```

---

## LLM / AI Security

Apps that call LLMs inherit a new attack surface:

- **Model output is untrusted.** Never pass it into `eval`, SQL, a shell, `innerHTML`, or a file path.
- **Prompts can be hijacked.** Untrusted text in the context can carry instructions. Enforce permissions in code, not in the prompt.
- **Keep secrets out of prompts.** Anything in the context can be echoed back.
- **Constrain tool permissions.** Scope tools to minimum, require confirmation for destructive actions.
- **Bound consumption.** Cap tokens, request rate, and recursion depth.
- **Isolate RAG data.** Partition embeddings per tenant.

```typescript
// Model output → parse → validate → encode
let intent;
try {
  intent = CommandSchema.parse(JSON.parse(await llm.replyJson(msg)));
} catch {
  throw new ValidationError('unexpected model output');
}
await runAllowlistedAction(intent.action, intent.params);
```

---

## Attacks Without Patches

Some security issues can't be fixed with a version bump:

| Issue | What it is | What to do |
|---|---|---|
| **Secrets committed** | Token pushed to remote | Rotate immediately. Deleting the line is not enough. |
| **Typosquat** | `cross-env` vs `crossenv` | Review new deps. Watch for lookalike names. |
| **postinstall script** | Package runs code on install | Audit unknown packages before adding. |
| **Lockfile not committed** | `npm install` picks up floating versions | Lockfile committed. CI uses `npm ci`. |

---

## Hardening Rules Summary

| Always Do | Ask First | Never Do |
|---|---|---|
| Validate all input at boundaries | Changing auth logic | Commit secrets to VCS |
| Parameterize queries | Storing new PII types | Log sensitive data |
| Encode output (XSS prevention) | Adding integrations | Trust client-side validation |
| HTTPS for all external communication | Changing CORS | Disable security headers |
| Hash passwords (bcrypt/scrypt/argon2) | Adding file uploads | eval() / innerHTML with user data |
| Security headers (CSP, HSTS) | Modifying rate limits | sessions in localStorage |
| httpOnly + secure + sameSite cookies | Granting elevated roles | Expose stack traces to users |
| npm audit before release | | |

---

## Common Traps

| "Internal tool — security doesn't matter" | Internal tools get compromised. Attackers target the weakest link. |
|---|---|
| "We'll add security later" | Retrofitting security is 10x harder than building it in. |
| "The framework handles security" | Frameworks provide tools, not guarantees. |
| "It's just a prototype" | Prototypes become production. Build habits from day one. |
| "It's just LLM output, it's only text" | That "text" can be a SQL statement. |

## Red Flags

- User input passed directly to SQL, shell, or HTML
- Secrets in source code or git history
- Endpoints without auth or authorization checks
- CORS with wildcard origins
- No rate limiting on auth endpoints
- Stack traces exposed to users
- Server fetches user-supplied URLs without allowlist (SSRF)
- LLM output passed into query, DOM, shell, or eval

## Verification

- [ ] npm audit shows no critical/high vulnerabilities
- [ ] No secrets in source code or git history
- [ ] All user input validated at system boundaries
- [ ] Auth + authorization checked on every protected endpoint
- [ ] Security headers present in response
- [ ] Error responses don't expose internals
- [ ] Rate limiting active on auth endpoints
- [ ] Server-side URL fetches validated against allowlist
- [ ] LLM output validated and encoded before use
