# Interface Design Reference

Build interface design with craft and consistency.

## Scope

**Use for:** Dashboards, admin panels, SaaS apps, tools, settings pages, data interfaces.

**Not for:** Landing pages, marketing sites, campaigns. Use frontend-design for those.

---

# The Problem

Generic output comes from following patterns without intent. The gap between stated intent and code generation is where defaults win.

The process below helps. But process alone doesn't guarantee craft.

---

# Where Defaults Hide

**Typography feels like a container.** Pick something readable, move on. But typography isn't holding your design — it IS your design.

**Navigation feels like scaffolding.** Build the sidebar, add the links, get to the real work. But navigation isn't around your product — it IS your product.

**Data feels like presentation.** You have numbers, show numbers. But a number on screen is not design. The question is: what does this number mean to the person looking at it?

**Token names feel like implementation detail.** But your CSS variables are design decisions.

---

# Intent First

Before touching code, answer these:

**Who is this human?**
Not "users." The actual person. Where are they when they open this? What's on their mind?

**What must they accomplish?**
The verb. Grade these submissions. Find the broken deployment. Approve the payment.

**What should this feel like?**
Warm like a notebook? Cold like a terminal? Dense like a trading floor? Calm like a reading app?

If you cannot answer these with specifics, stop. Ask the user. Do not guess. Do not default.

## Every Choice Must Be A Choice

For every decision, you must be able to explain WHY.

- Why this layout and not another?
- Why this color temperature?
- Why this typeface?
- Why this spacing scale?
- Why this information hierarchy?

If your answer is "it's common" or "it's clean" or "it works" — you haven't chosen. You've defaulted.

## Sameness Is Failure

If another AI, given a similar prompt, would produce substantially the same output — you have failed.

## Intent Must Be Systemic

Saying "warm" and using cold colors is not following through. Intent is not a label — it's a constraint that shapes every decision.

---

# Product Domain Exploration

Generic output: Task type → Visual template → Theme
Crafted output: Task type → Product domain → Signature → Structure + Expression

## Required Outputs

**Do not propose any direction until you produce all four:**

**Domain:** Concepts, metaphors, vocabulary from this product's world. Not features — territory. Minimum 5.

**Color world:** What colors exist naturally in this product's domain? List 5+.

**Signature:** One element — visual, structural, or interaction — that could only exist for THIS product.

**Defaults:** 3 obvious choices for this interface type — visual AND structural.

---

# Craft Foundations

## Subtle Layering

This is the backbone of craft. Regardless of direction, product type, or visual style — this principle applies to everything.

### Surface Elevation

Surfaces stack. Build a numbered system — base, then increasing elevation levels. In dark mode, higher elevation = slightly lighter. In light mode, higher elevation = slightly lighter or uses shadow.

**Key decisions:**

- **Sidebars:** Same background as canvas, not different.
- **Dropdowns:** One level above their parent surface.
- **Inputs:** Slightly darker than their surroundings, not lighter.

### Borders

Borders should disappear when you're not looking for them, but be findable when you need structure.

---

# Design Principles

## Token Architecture

Every color in your interface should trace back to a small set of primitives: foreground, background, border, brand, and semantic.

## Spacing

Pick a base unit and stick to multiples.

## Depth

Choose ONE approach and commit:
- **Borders-only** — Clean, technical.
- **Subtle shadows** — Soft lift.
- **Layered shadows** — Premium, dimensional.
- **Surface color shifts** — Background tints.

Don't mix approaches.

## Border Radius

Sharper feels technical. Rounder feels friendly. Build a scale.

## Typography

Build distinct levels distinguishable at a glance.

## Card Layouts

Design each card's internal structure for its specific content — but keep surface treatment consistent.

## Controls

Build custom components — don't rely on native OS-styled elements.

## Iconography

Icons clarify, not decorate — if removing an icon loses no meaning, remove it.

## Animation

Fast micro-interactions, smooth easing. Use deceleration easing.

## States

Every interactive element needs states: default, hover, active, focus, disabled. Data needs states too: loading, empty, error.

---

# Avoid

- **Harsh borders** — if borders are the first thing you see, they're too strong
- **Dramatic surface jumps** — elevation changes should be whisper-quiet
- **Inconsistent spacing** — the clearest sign of no system
- **Mixed depth strategies** — pick one approach and commit
- **Missing interaction states** — hover, focus, disabled, loading, error
- **Dramatic drop shadows** — shadows should be subtle
- **Pure white cards on colored backgrounds**
- **Multiple accent colors** — dilutes focus

---

# Workflow

1. Explore domain — Produce all four required outputs
2. Propose — Direction must reference all four
3. Confirm — Get user buy-in
4. Build — Apply principles
5. Evaluate — Run craft checks before showing
6. Offer to save

## If Project Has system.md

Read `.interface-design/system.md` and apply. Decisions are made.

## If No system.md

Follow the workflow above. After completing, offer to save patterns to `.interface-design/system.md`.
