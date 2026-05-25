---
name: write-a-skill
description: Create new agent skills with proper structure, progressive disclosure, triggers, and bundled resources. Use when user wants to create, write, or build a new skill.
triggers:
  - "create a skill"
  - "write a skill"
  - "make a skill"
  - "build a skill"
  - "new skill"
  - "skill for"
---

# Writing Skills: Create High-Quality Agent Skills

Create new agent skills with proper structure, progressive disclosure, and bundled resources.

## Process

### 1. Gather Requirements

Ask user about:

- What task/domain does the skill cover?
- What specific use cases should it handle?
- Does it need executable scripts or just instructions?
- Any reference materials to include?
- What should trigger it? (keywords, phrases, contexts)

### 2. Draft the Skill

Create:

- `SKILL.md` with concise instructions + YAML frontmatter
- Additional reference files if content exceeds ~100 lines
- Utility scripts if deterministic operations needed

### 3. Review with User

Present draft and ask:

- Does this cover your use cases?
- Anything missing or unclear?
- Should any section be more/less detailed?

## Skill Structure

```
skill-name/
├── SKILL.md           # Main instructions (required)
├── REFERENCE.md       # Detailed docs (if needed)
├── EXAMPLES.md        # Usage examples (if needed)
└── scripts/           # Utility scripts (if needed)
    └── helper.js
```

## SKILL.md Template

```md
---
name: skill-name
description: >
  Brief description of capability. 
  Use when [specific triggers with keywords].
triggers:
  - "trigger phrase 1"
  - "trigger phrase 2"
---

# Skill Name

## Quick Start

[Minimal working example or 1-sentence summary]

## When to Use

This skill activates when:

- User says X
- User wants Y
- Context is Z

## Core Workflow

[Step-by-step processes with checklists for complex tasks]

## Key Principles

[What makes this skill different]

## Anti-Patterns

[What NOT to do]

## Advanced / Reference

[For complex skills, link to separate files:

- See [REFERENCE.md](REFERENCE.md)
- See [EXAMPLES.md](EXAMPLES.md)]
```

## Description Requirements

The description is **the only thing the agent sees** when deciding which skill to load. It's surfaced in the system prompt alongside all other installed skills.

**Goal**: Give the agent just enough info to know:

1. What capability this skill provides
2. When/why to trigger it (specific keywords, contexts)

**Format**:

- First sentence: what it does
- Second sentence: "Use when [specific triggers]"

**Good example**:

```
Extract text and tables from PDF files, fill forms, merge documents.
Use when working with PDF files or when user mentions PDFs, forms, or document extraction.
```

**Bad example**:

```
Helps with documents.
```

## Triggers

The `triggers` field in frontmatter is a list of phrases that should activate this skill. Make them specific but not overly narrow.

**Good triggers**:

```yaml
triggers:
  - "debug this"
  - "fix this bug"
  - "this is broken"
  - "why is this failing"
```

**Bad triggers**:

```yaml
triggers:
  - "help" # too broad
```

## When to Split Files

Split into separate files when:

- `SKILL.md` exceeds ~100 lines
- Content has distinct domains (finance vs sales schemas)
- Advanced features are rarely needed

Keep `SKILL.md` tight. Link to references for deep dives.

## Review Checklist

Before considering the skill complete:

- [ ] Description includes triggers ("Use when...")
- [ ] `SKILL.md` under ~100 lines (or references split out)
- [ ] Triggers are specific but not overly narrow
- [ ] No time-sensitive info embedded
- [ ] Consistent terminology throughout
- [ ] Concrete examples included if appropriate
- [ ] References are at most one level deep

## Publishing

Once complete:

- The skill directory should be placed in the skills folder
- The symlink (if used) will make it available to the agent
- Test by using one of the trigger phrases in a conversation

---

## Related Skills

- **planning** - Use when planning the skill structure and behavior
- **rapidfire** - For stress-testing the skill design and uncovering blind spots
