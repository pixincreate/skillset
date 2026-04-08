---
name: spec-writer
description: Write clear, actionable technical specifications that bridge intent and implementation. Use when user wants to create specs, PRDs, technical docs, or needs help writing a specification.
---

# Spec Writer

Write technical specifications that are clear, actionable, and implementation-ready.

## Overview

This skill helps create:

- Technical specifications (SPEC.md)
- Product Requirements Documents (PRDs)
- RFCs and design documents
- Technical documentation
- API specifications

## When to Use

Use this skill when:

- Planning a new feature or system
- Writing technical documentation
- Creating RFCs for proposals
- Documenting existing systems

## Specification Structure

### 1. Overview

- What problem does this solve?
- Why does it matter?
- Who is this for?

### 2. Requirements

- **Functional**: What the system must do
- **Non-functional**: Performance, security, scalability
- **Constraints**: What limits what we can do

### 3. Design

- High-level architecture
- Data model (if applicable)
- API surface (if applicable)
- Key decisions and rationale

### 4. Implementation Plan

- Phases or milestones
- Dependencies
- Risks and mitigations

### 5. Out of Scope

- What are we NOT doing?
- What's deferred to later?

## Writing Principles

### Clarity Over Brevity

Write to be understood, not to sound smart. If a simple explanation exists, use it.

### Concrete Over Abstract

Instead of "handle errors gracefully," say "return HTTP 500 with error JSON: { error: 'message', code: 'INTERNAL' }"

### Examples Are Essential

Show, don't just tell. Include:

- Usage examples
- Edge cases
- Error scenarios
- API examples

### Decisions Need Rationale

Every significant decision should answer: "Why this approach and not X, Y, Z?"

## Common Sections by Type

### Feature Spec

```
## Overview
## User Stories
## Requirements
  - Functional
  - Non-functional
## Design
  - Architecture
  - Data Model
  - API
## Implementation
  - Phases
  - Dependencies
## Testing
## Out of Scope
## Open Questions
```

### System Spec

```
## Overview
## Background
## Architecture
## Components
## Data Flow
## API Contracts
## Security
## Scalability
## Risks
## Alternatives Considered
```

### API Spec

```
## Overview
## Resources
## Endpoints
  - Path
  - Method
  - Request Body
  - Response
  - Errors
## Authentication
## Rate Limits
## Examples
```

## Workflow

### 1. Gather Information

Ask questions:

- What's the scope?
- Who are the stakeholders?
- What's already decided?
- What decisions need to be made?

### 2. Draft Structure

Create outline first. Validate with user before filling in.

### 3. Fill Iteratively

Write section by section, getting feedback.

### 4. Review

Check for:

- Ambiguous language
- Missing edge cases
- Unclear requirements
- Implementation gaps

## Quality Checklist

- [ ] Every requirement is testable
- [ ] Every decision has rationale
- [ ] Examples exist for non-trivial parts
- [ ] Out of scope is explicit
- [ ] Open questions are documented
- [ ] Technical terms are defined
