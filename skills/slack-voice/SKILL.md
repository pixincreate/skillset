---
name: slack-voice
description: Translates frustrated or casual messages into polished, corporate-friendly Slack messages that feel natural, human, and conversational.
---

# Slack Voice

Transform raw thoughts into polished Slack messages that sound like a real human, not corporate jargon.

## Overview

This skill takes frustrated, messy, or casual messages and translates them into:

- Professional but human
- Natural and conversational
- Witty and relatable
- Structured for async communication

## Rules

1. **No emdashes (—)** - Use commas, periods, or semicolons instead
2. **No curly quotes (“ and ”)** - Use straight quotes (also called a dumb quote) instead (")
3. **Must feel human-written** - Not AI, not marketing, not corporate
4. **Conversational tone** - Like you're talking to coworkers who respect you
5. **Invite responses** - Through quality content, not desperate "please reply" calls
6. **Keep it real** - Don't over-polish into meaninglessness

## Common Transformations

### Frustration to Professional

**Input:** "This bug has been open for 3 weeks and nobody is looking at it"
**Output:** Hey folks, wanted to flag this one - been open for a bit and could use eyes on it. Happy to pair on the investigation if helpful.

### Vague to Actionable

**Input:** "We should probably look at the database stuff soon"
**Output:** Quick thought - might be worth digging into the DB queries on the dashboard page. Seeing some latency there that could impact users.

### Defensive to Collaborative

**Input:** "That wasn't my fault, the docs were wrong"
**Output:** FWIW, I hit a snag here - the docs didn't match the actual behavior. Happy to update them if that helps others avoid this.

### Venting to Productive

**Input:** "This is so annoying, I've been stuck on this for hours"
**Output:** Spent a few hours on this and hitting a wall. Anyone who knows the auth flow around here willing to take a quick look?

## Tone Guidelines

- Start with a greeting if the message is substantial
- Use "hey" or "hi" - not "Dear Team" or "All,"
- State the purpose early - don't bury the lead
- Offer help or ask for it genuinely
- Keep paragraphs short - 2-3 sentences max
- End with what you're hoping for (feedback, eyes, help, etc.)

## What to Avoid

- Corporate speak: "reach out," "leverage," "circle back," "synergy"
- Over-apologizing: "sorry but" or "I apologize for"
- Passive aggressive: "as I mentioned earlier" or "per my last email"
- Desperate calls: "PLEASE HELP" or "Anyone??"
- Emdashes - they're forbidden in this skill

## Examples

**Requesting help:**

> Hey, running into something weird with the API response times. Anyone familiar with the rate limiting logic? Happy to share what I'm seeing.

**Flagging an issue:**

> Heads up - found a bug in the checkout flow that's letting orders go through without payment. Have a fix ready but want to verify it's not a deeper issue first.

**Pushing back:**

> Took a look at this and I think we might be overcomplicating it. Happy to walk through what I found - basically we could probably solve this with a simpler approach.

**Sharing bad news:**

> Bad news - the migration hit an unexpected constraint and needs another day. I'll keep this moving and update when there's a clear ETA.

## Format

- Use standard punctuation
- One blank line between paragraphs if multiple
- Emoji are fine in small amounts (thumbs up, eyes, checkmark) - but not required
- No bullet points unless absolutely necessary, and keep them short
