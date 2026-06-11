---
name: observability-and-instrumentation
description: "Instruments code so production behavior is visible and diagnosable. Use when adding logging, metrics, tracing, or alerting. Use when shipping any feature that runs in production and you need evidence it works. Use when production issues are reported but you can't tell what happened from the available data."
triggers:
  - "observability"
  - "logging"
  - "metrics"
  - "tracing"
  - "monitoring"
  - "telemetry"
  - "OpenTelemetry"
  - "instrumentation"
  - "alerting"
---

# Observability and Instrumentation

## Why This Matters

A feature without telemetry is a black box. When it breaks — and it will break — the first user report triggers archaeology instead of a query. You can't ask a production system "what happened?" if it never emitted the answer.

Observability is the ability to answer that question from the outside, using signals the code emits as it runs. Instrumentation is not a post-launch add-on. It's written alongside the feature, the same way tests are.

## When to Apply

- Building any feature that will run in production
- Adding a service, endpoint, background job, or external integration
- A past incident took too long to diagnose ("we couldn't tell what happened")
- Reviewing a PR that adds I/O, retries, queues, or cross-service calls

**Not for:** diagnosing a live failure (use diagnose), profiling known slowness (use performance-optimization).

---

## Workflow

### 1. Name the Questions First

Telemetry without a question is noise. Before adding any instrumentation, write down 2–4 questions an on-call engineer will ask about this feature:

```
FEATURE: checkout payment retry
ON-CALL QUESTIONS:
1. What fraction of payments succeed first attempt vs after retry?
2. When a payment fails permanently, why?
3. Is the payment provider slower than usual?

→ Every signal below must help answer one of these.
```

If you can't name the questions, you're not ready to instrument. You'll log everything and learn nothing.

### 2. Pick the Right Signal

| Signal | Answers | Cost | Example |
|---|---|---|---|
| **Log** | What happened in this specific case? | Per-event; grows with traffic | `payment_failed` with error code |
| **Metric** | How often / how fast, in aggregate? | Fixed per series; cheap | p99 latency of provider calls |
| **Trace** | Where did time go across services? | Per-request; usually sampled | Slow checkout, broken down by hop |

Rule of thumb: metrics tell you **that** something is wrong, traces tell you **where**, logs tell you **why**.

### 3. Structured Logging

Log events, not prose. Every line is a JSON object with a stable event name:

```typescript
// BAD: string interpolation — unqueryable
logger.info(`Payment ${id} failed for user ${userId}`);

// GOOD: stable event name + structured fields
logger.warn({
  event: 'payment_failed',
  paymentId: id,
  provider: 'stripe',
  errorCode: err.code,
  attempt: n,
}, 'payment failed');
```

**Log levels:**

| Level | Meaning | On-call action |
|---|---|---|
| `error` | Invariant broken; someone may need to act | Investigate |
| `warn` | Degraded but handled (retry succeeded) | Watch trends |
| `info` | Significant business event (order placed) | None |
| `debug` | Diagnostic detail | Off in production by default |

**Correlation IDs are mandatory.** Generate (or accept) a request ID at the boundary and attach it to every log line, span, and outbound call:

```typescript
app.use((req, res, next) => {
  req.id = req.headers['x-request-id'] ?? crypto.randomUUID();
  req.log = logger.child({ requestId: req.id });
  res.setHeader('x-request-id', req.id);
  next();
});
```

Never log secrets, tokens, passwords, or full PII.

### 4. RED Metrics

For request-driven services, instrument **RED** on every endpoint and dependency:

- **Rate** — requests/sec
- **Errors** — failure rate
- **Duration** — latency histogram (never average)

```typescript
import { Histogram } from 'prom-client';

const httpDuration = new Histogram({
  name: 'http_request_duration_seconds',
  help: 'HTTP request duration',
  labelNames: ['method', 'route', 'status_class'],  // '2xx', not '200'
  buckets: [0.05, 0.1, 0.25, 0.5, 1, 2.5, 5],
});
```

**Cardinality is the failure mode.** Labels must come from small, fixed sets:

```
OK:      route="/api/tasks/:id"   status_class="5xx"   provider="stripe"
NEVER:   user_id, email, request_id, full URL, error message
```

Track percentiles, never averages. An average hides the 1% of users having a terrible time.

### 5. Distributed Tracing

Use OpenTelemetry — it's the vendor-neutral standard:

```typescript
import { NodeSDK } from '@opentelemetry/sdk-node';
import { getNodeAutoInstrumentations } from '@opentelemetry/auto-instrumentations-node';

const sdk = new NodeSDK({
  serviceName: 'checkout-service',
  instrumentations: [getNodeAutoInstrumentations()],
});
sdk.start();
```

Add manual spans around meaningful internal units. Propagate context across every async boundary or the trace dies at the gap.

### 6. Alert on Symptoms, Not Causes

```
PAGE (user-facing):                     DASHBOARD (investigate later):
error rate > 1% for 5 min               CPU at 85%
p99 latency > 2s                        one pod restarted
queue age > 10 min                      disk at 70%
```

Rules for every alert:
1. **Must be actionable** — if response is "ignore it", delete the alert
2. **Must link to a runbook** — even three lines
3. **Threshold + duration justified** by SLO or historical data
4. **Two severities only:** page (act now) and ticket (act this week)

### 7. Verify the Telemetry

Instrumentation is code; it can be wrong. Before calling it done:

- Force an error in staging → find it in logs by `requestId`
- Send test traffic → confirm metric series appear with expected labels
- Follow one request across services in tracing → no broken spans
- Fire each new alert once → confirm it reaches the right channel

---

## Common Traps

| "I'll add logging after it works" | "After" means "after the first incident" — the most expensive moment to discover you're blind. |
|---|---|
| "More logs = more observability" | Unstructured noise makes incidents slower. Three queryable events beat 300 prose lines. |
| "console.log is fine for now" | Unstructured output can't be filtered, correlated, or alerted on. |
| "Dashboards will show us" | Dashboards without defined questions show everything except the answer. |
| "Alert on everything, we'll tune later" | A noisy pager trains people to ignore it. The tuning never happens. |
| "User ID as a metric label helps debugging" | It makes your metrics backend fall over. High-cardinality belongs in logs and traces. |

## Red Flags

- Feature PR with retries/queues/external calls and zero new telemetry
- Log lines built by string interpolation instead of structured fields
- No correlation/request ID — each log line is an orphan
- Metrics labeled with user IDs, raw URLs, or error message text
- Latency tracked as average with no percentiles
- Alerts that fire daily and get acknowledged without action
- Alerts on CPU/memory paging humans while error rate is unmonitored
- Secrets or full request bodies in logs

## Verification

- [ ] On-call questions for this feature are written down; each signal maps to one
- [ ] All log output is structured (JSON), with stable event names and correlation ID on every line
- [ ] No secrets, tokens, or unredacted PII in any log line
- [ ] RED metrics exist for every new endpoint and external dependency; label sets are bounded
- [ ] Latency is a histogram; p95/p99 are queryable
- [ ] A single request can be followed end-to-end in tracing without broken spans
- [ ] Every new alert is symptom-based, has a runbook link, and was test-fired once
- [ ] An induced failure in staging was located via telemetry alone, without reading the source
