---
name: api-and-interface-design
description: "Guides stable API and interface design. Use when designing APIs, module boundaries, or any public interface. Use when creating REST or GraphQL endpoints, defining type contracts between modules, or establishing boundaries between frontend and backend."
triggers:
  - "API design"
  - "endpoint"
  - "REST"
  - "interface"
  - "contract"
  - "schema"
  - "types"
---

# API and Interface Design

## Why This Matters

Every interface is a contract. Once consumers depend on it, every observable behavior — documented or not — becomes a commitment. Change an error message format and something breaks. Return a field in a different order and something breaks. A good interface makes the right thing easy and the wrong thing hard. A bad one creates a permanent tax on every consumer.

## When to Apply

- Designing new API endpoints or module boundaries
- Creating component prop interfaces
- Changing existing public interfaces
- Establishing contracts between frontend and backend

---

## Principles

### Hyrum's Law

> With enough users, all observable behaviors will be depended on by somebody.

This means:
- **Be intentional about what you expose.** Every behavior is a potential commitment.
- **Don't leak implementation details.** If users can observe it, they will depend on it.
- **Plan for deprecation at design time.**
- **Tests are not enough.** Even perfect contract tests don't prevent real users from depending on quirks.

### The One-Version Preference

Avoid forcing consumers to choose between versions. Diamond dependency problems arise when different consumers need different versions. Design for a world where one version exists at a time — extend rather than fork.

---

## Five Design Rules

### Rule 1: Contract First

Define the interface before implementing it. The contract is the spec.

```typescript
interface TaskAPI {
  createTask(input: CreateTaskInput): Promise<Task>;
  listTasks(params: ListTasksParams): Promise<PaginatedResult<Task>>;
  getTask(id: string): Promise<Task>;
  updateTask(id: string, input: UpdateTaskInput): Promise<Task>;
  deleteTask(id: string): Promise<void>;
}
```

### Rule 2: Consistent Error Semantics

Pick one error strategy. Use it everywhere.

```typescript
interface APIError {
  error: {
    code: string;        // "VALIDATION_ERROR"
    message: string;     // "Email is required"
    details?: unknown;
  };
}

// Status codes
// 400 → Invalid data
// 401 → Not authenticated
// 403 → Not authorized
// 404 → Not found
// 409 → Conflict (duplicate)
// 422 → Validation failed
// 500 → Server error (never expose internals)
```

Don't mix patterns. If some endpoints throw, others return null, and others return `{ error }`, the consumer can't predict behavior.

### Rule 3: Validate at Boundaries

Trust internal code. Validate where external input enters:

```
WHERE VALIDATION BELONGS:
- API route handlers (user input)
- Form submission handlers
- External service response parsing (always treat as untrusted)
- Environment variable loading

WHERE IT DOES NOT BELONG:
- Between internal functions sharing type contracts
- In utilities called by already-validated code
- On data from your own database
```

```typescript
app.post('/api/tasks', async (req, res) => {
  const result = CreateTaskSchema.safeParse(req.body);
  if (!result.success) {
    return res.status(422).json({
      error: { code: 'VALIDATION_ERROR', message: 'Invalid data',
        details: result.error.flatten() }
    });
  }
  const task = await taskService.create(result.data);
  return res.status(201).json(task);
});
```

### Rule 4: Prefer Addition Over Modification

```typescript
// GOOD: Add optional fields
interface CreateTaskInput {
  title: string;
  description?: string;          // optional
  priority?: 'low' | 'medium' | 'high';  // added later, optional
}

// BAD: Change types or remove fields
interface CreateTaskInput {
  title: string;
  // description: string;  // removed — breaks consumers
  priority: number;         // changed type — breaks consumers
}
```

### Rule 5: Predictable Naming

| Element | Convention | Example |
|---|---|---|
| REST endpoints | Plural nouns, no verbs | `GET /api/tasks` |
| Query params | camelCase | `?sortBy=createdAt` |
| Response fields | camelCase | `createdAt`, `updatedAt` |
| Booleans | is/has/can prefix | `isComplete`, `hasAttachments` |
| Enums | UPPER_SNAKE | `IN_PROGRESS`, `COMPLETED` |

---

## REST Patterns

### Resource Design

```
GET    /api/tasks              → List (with query params)
POST   /api/tasks              → Create
GET    /api/tasks/:id          → Get one
PATCH  /api/tasks/:id          → Partial update
DELETE /api/tasks/:id          → Delete
GET    /api/tasks/:id/comments → Sub-resource list
POST   /api/tasks/:id/comments → Sub-resource create
```

### Pagination

```
GET /api/tasks?page=1&pageSize=20&sortBy=createdAt&sortOrder=desc

Response:
{ "data": [...], "pagination": {
    "page": 1, "pageSize": 20, "totalItems": 142, "totalPages": 8
  }
}
```

### PATCH Semantics

Accept partial objects — only update what's provided:

```
PATCH /api/tasks/123
{ "title": "Updated title" }
```

---

## TypeScript Patterns

### Discriminated Unions for Variants

```typescript
type TaskStatus =
  | { type: 'pending' }
  | { type: 'in_progress'; assignee: string; startedAt: Date }
  | { type: 'completed'; completedAt: Date; completedBy: string }
  | { type: 'cancelled'; reason: string; cancelledAt: Date };
```

### Input/Output Separation

```typescript
// Input — what the caller provides
interface CreateTaskInput {
  title: string;
  description?: string;
}

// Output — what the system returns (server-generated fields)
interface Task {
  id: string;
  title: string;
  description: string | null;
  createdAt: Date;
  updatedAt: Date;
  createdBy: string;
}
```

### Branded Types for IDs

```typescript
type TaskId = string & { readonly __brand: 'TaskId' };
type UserId = string & { readonly __brand: 'UserId' };

function getTask(id: TaskId): Promise<Task> { ... }
// Prevents: getTask(userId) — type error
```

---

## Common Traps

| "We'll document the API later" | The types ARE the documentation. Define them first. |
|---|---|
| "We don't need pagination for now" | You will the moment someone has 100+ items. Add it from the start. |
| "PATCH is complicated, let's use PUT" | PUT requires the full object every time. PATCH is what clients actually want. |
| "Nobody uses that undocumented behavior" | Hyrum's Law: if it's observable, somebody depends on it. |
| "We'll just maintain two versions" | Multiple versions multiply maintenance cost. Extend, don't fork. |
| "Internal APIs don't need contracts" | Internal consumers are still consumers. Contracts prevent coupling. |

## Red Flags

- Endpoints returning different shapes depending on conditions
- Inconsistent error formats across endpoints
- Validation scattered through internal code instead of at boundaries
- Breaking changes to existing fields (type changes, removals)
- List endpoints without pagination
- Verbs in REST URLs (`/api/createTask`)
- Third-party API responses used without validation

## Verification

- [ ] Every endpoint has typed input and output schemas
- [ ] Error responses follow a single consistent format
- [ ] Validation happens at system boundaries only
- [ ] List endpoints support pagination
- [ ] New fields are additive and optional (backward compatible)
- [ ] Naming conventions are consistent across all endpoints
- [ ] Types/contracts committed alongside implementation
