---
name: architecture
description: Software architecture and system design guidance. Use when designing new systems, evaluating architecture, planning refactoring, making technology decisions, or analyzing design trade-offs. Applies SOLID principles and established patterns to create maintainable, scalable systems.
---

# Architecture Skill

## Core Principle

**Design for change**: Build systems that are easy to understand, test, and modify.

## Design Process

1. **Understand Requirements**
   - Functional: What must the system do?
   - Non-functional: Performance, scale, security needs?
   - Constraints: Budget, timeline, existing systems, team skills?

2. **Analyze Current State**
   - Review existing architecture
   - Identify pain points and technical debt
   - Map data flow and dependencies
   - Document integration points

3. **Design Solution**
   - Choose appropriate patterns
   - Define component boundaries
   - Design data model
   - Plan for scalability and security

4. **Document Decisions**
   - Use Architecture Decision Records (ADRs)
   - Create system diagrams (C4 model)
   - Document trade-offs and rationale

## SOLID Principles

Apply these to all design decisions:

- **Single Responsibility**: One reason to change per module
- **Open/Closed**: Extend behavior without modifying existing code
- **Liskov Substitution**: Subtypes must be substitutable
- **Interface Segregation**: Many specific interfaces > one general
- **Dependency Inversion**: Depend on abstractions, not concretions

## Common Architectural Patterns

### Layered Architecture
```
Presentation (UI)
    ↓
Business Logic
    ↓
Data Access
    ↓
Database
```
**Use when:** Clear separation needed, traditional monolith

### Microservices
- Independent, deployable services
- Each owns its data
- Communicate via APIs/events

**Use when:** Need independent scaling, team autonomy, polyglot requirements

**Trade-offs:** Complexity vs flexibility

### Event-Driven
- Components communicate via events
- Loose coupling between producers/consumers

**Use when:** Need async processing, real-time updates, audit trail

### Domain-Driven Design (DDD)
- Model based on business domain
- Bounded contexts with ubiquitous language
- Entities, value objects, aggregates

**Use when:** Complex business logic, multiple subdomains

### Hexagonal (Ports & Adapters)
```
Core Domain (Ports)
    ↕
Adapters (DB, API, UI, etc.)
```
**Use when:** Need flexibility in swapping infrastructure

## Component Design Checklist

When designing components:
- [ ] Single, clear responsibility
- [ ] Well-defined interface/contract
- [ ] Minimal coupling to other components
- [ ] High cohesion internally
- [ ] Testable in isolation
- [ ] Error handling defined
- [ ] State management clear

## Data Architecture

### Database Selection
**SQL (PostgreSQL, MySQL)**
- Structured data with relationships
- ACID transactions required
- Complex queries needed

**NoSQL (MongoDB, DynamoDB)**
- Flexible schema
- Horizontal scaling priority
- Document or key-value data

**Cache (Redis, Memcached)**
- Frequently accessed data
- Session storage
- Rate limiting

### Data Flow Patterns
- Keep transformations explicit
- Validate at system boundaries
- Plan for data migration
- Consider event sourcing for audit trails

## Scalability Patterns

### Horizontal Scaling
- Add more instances behind load balancer
- Requires stateless services
- Database becomes bottleneck

### Vertical Scaling
- Add more resources to instances
- Simpler but has limits
- Can be expensive

### Caching Strategy
- Cache at multiple levels (CDN, server, database)
- Use cache invalidation strategy
- Consider cache-aside vs write-through

### Database Optimization
- Add indexes for frequent queries
- Use read replicas for read-heavy workloads
- Implement connection pooling
- Consider database sharding for massive scale

### Async Processing
- Queue long-running tasks
- Use background workers
- Consider message brokers (RabbitMQ, Kafka)

## Security Architecture

Essential security layers:
- **Authentication**: Who are you? (JWT, OAuth, sessions)
- **Authorization**: What can you do? (RBAC, ABAC)
- **Encryption**: Data at rest and in transit (TLS, AES)
- **Input Validation**: Never trust user input
- **Rate Limiting**: Prevent abuse
- **Secrets Management**: Never commit secrets (use vaults)
- **Security Headers**: CORS, CSP, HSTS
- **Audit Logging**: Track security events

## Trade-Off Analysis Framework

For each major decision, consider:

| Factor | Option A | Option B |
|--------|----------|----------|
| Performance | | |
| Scalability | | |
| Maintainability | | |
| Cost | | |
| Time to Implement | | |
| Team Familiarity | | |
| Flexibility | | |
| Risk | | |

**Document the decision** with rationale in an ADR.

## Architecture Decision Record (ADR) Template

```markdown
# ADR-XXX: [Short Title]

## Status
[Proposed | Accepted | Deprecated | Superseded]

## Context
What problem are we solving? What constraints exist?

## Decision
What did we decide to do?

## Consequences
Positive and negative outcomes of this decision.

## Alternatives Considered
What else did we consider and why was it rejected?
```

## Anti-Patterns to Avoid

- **Big Ball of Mud**: No discernible structure
- **Golden Hammer**: Same solution for every problem
- **Premature Optimization**: Optimizing before knowing bottlenecks
- **Distributed Monolith**: Microservices with tight coupling
- **God Object**: One component doing everything
- **Vendor Lock-in**: Over-dependency on specific vendor
- **Not Invented Here**: Refusing to use existing solutions

## Technology Selection Criteria

Evaluate based on:
1. **Fitness**: Does it solve the problem?
2. **Team Fit**: Can team learn and maintain it?
3. **Community**: Active support and ecosystem?
4. **Longevity**: Will it be maintained long-term?
5. **Performance**: Meets performance requirements?
6. **Cost**: Licensing and infrastructure costs?
7. **Integration**: Works with existing stack?

## Diagram Types (C4 Model)

1. **Context**: System and external dependencies
2. **Container**: High-level technology choices
3. **Component**: Internal structure
4. **Code**: Class diagrams (optional)

Use Mermaid, PlantUML, or draw.io for diagrams.

## Modernization Strategy (Strangler Fig Pattern)

When modernizing legacy systems:
1. Identify bounded contexts
2. Create new implementation alongside old
3. Route traffic incrementally to new system
4. Add anti-corruption layer between systems
5. Gradually strangle old system
6. Decommission when fully migrated

## Quick Reference: Pattern Selection

| Need | Pattern |
|------|---------|
| Simple CRUD app | Layered architecture |
| Independent team scaling | Microservices |
| Real-time updates | Event-driven |
| Complex business rules | Domain-Driven Design |
| Swap infrastructure easily | Hexagonal architecture |
| Read/write optimization | CQRS |
| Data access abstraction | Repository pattern |

## Review Checklist

Before finalizing architecture:
- [ ] Meets all functional requirements
- [ ] Meets non-functional requirements (performance, scale, security)
- [ ] Scalable for expected growth
- [ ] Maintainable by team
- [ ] Testable
- [ ] Cost-effective
- [ ] Follows established patterns
- [ ] Documented with diagrams and ADRs
- [ ] Error handling and resilience considered
- [ ] Monitoring and observability planned
