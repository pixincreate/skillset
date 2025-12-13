---
name: collaboration
description: Effective team collaboration and communication practices. Use when working with teams, conducting code reviews, pair programming, sharing knowledge, communicating across time zones, or providing/receiving feedback. Emphasizes clear communication and constructive collaboration.
---

# Collaboration Skill

## Core Principle

**Communicate early, often, and clearly**: Effective collaboration requires proactive, transparent communication.

## Communication Best Practices

### Be Clear and Specific
- State what you need or found
- Provide context and background
- Include links, file references (file.ts:123)
- Use examples when helpful

### Be Concise
- Get to the point
- Use bullet points for clarity
- Break down complex information
- Don't overwhelm with details

### Be Timely
- Respond within reasonable time
- Don't block others
- Communicate delays proactively
- Update status regularly

### Be Professional
- Assume good intent
- Focus on code, not person
- Be constructive, not critical
- Acknowledge contributions

## Code Review Collaboration

### Enhanced GitHub Review Workflow

**5-Step Review Process:**
1. **Review Analysis** (from code-quality-review skill):
   - Critical issues (blockers): Security, architecture breaks
   - Warnings: Logic errors, quality concerns
   - Suggestions: Style, documentation improvements

2. **Review Scoring**:
   - Score = 100 - (Critical×20) - (Warnings×5) - (Suggestions×1)
   - ✨ 95-100: Auto-approve
   - ✅ 90-94: Approve
   - ⚠️ 80-89: Request changes
   - ❌ 60-79: Block merge
   - 🚨 0-59: Critical block

3. **Line Number Specification**:
   - **ALWAYS** reference the NEW file version (PR HEAD commit)
   - Format: `file:line_number` (e.g., `src/file.rs:45`)
   - Include `line_reference: "NEW_FILE"` in all comments

4. **Comment Structure**:
   ```yaml
   - severity: CRITICAL | WARNING | SUGGESTION
     file: path/to/file
     line_number: 45
     line_reference: NEW_FILE
     issue: "Description of issue"
     current_code: |
       # Problematic code
     suggested_fix: |
       # Corrected code
   ```

5. **Publishing to GitHub**:
   - Use `github-review-publisher` to post comments
   - Format comments with emoji indicators:
     - 🚨 Critical: Security vulnerabilities
     - ⚠️ Warning: Logic errors
     - 💡 Suggestion: Improvements
   - Group related comments
   - Add summary at top of review

### GitHub Review Templates

**Critical Issues Template:**
```
🚨 {issue} - {impact}

Current:
```{language}
{current_code}
```

Fix:
```{language}
{suggested_fix}
```
```

**Warning Template:**
```
⚠️ {issue} - {reason}

Line: {file}:{line}
```

**Suggestion Template:**
```
💡 {suggestion} - {example}

```diff
- {current}
+ {improved}
```
```

### Review Best Practices

- **Be specific**: Point to exact lines in NEW file
- **Be actionable**: Provide code examples
- **Categorize properly**: Match severity to issue type
- **Check line numbers**: Validate against PR HEAD commit
- **Include context**: Explain why issue matters
- **Use GitHub features**: Threaded comments, suggestions

### Integration with Other Skills

This workflow works with:
- **pr-analysis**: Provides file list and scope
- **code-quality-review**: Generates review data
- **github-review-publisher**: Publishes comments to GitHub

### Common Pitfalls to Avoid

- ❌ Using line numbers from diff output
- ❌ Not verifying against NEW file version
- ❌ Missing severity categorization
- ❌ Vague comments without code examples
- ❌ Ignoring review score recommendations

### As Author

**PR Description:**
```markdown
## What
[Concise summary of changes]

## Why
[Business/technical rationale]

## How to Test
1. Run `npm install`
2. Start server with `npm start`
3. Navigate to /feature
4. Verify X happens

## Screenshots (if UI changes)
[Before/After images]

## Notes
- Breaking changes: [if any]
- Performance impact: [if significant]
- Security considerations: [if applicable]
```

**Responding to Feedback:**
- Address all comments
- Explain reasoning if disagreeing
- Ask questions if unclear
- Thank reviewers
- Update code promptly
- Request re-review when ready

### As Reviewer

**Effective Review Comments:**

✅ **Good:**
```
This could cause a performance issue with large datasets.
Consider using pagination here:
users.paginate(page: params[:page], per_page: 50)
```

❌ **Not Helpful:**
```
This is wrong.
```

**Comment Types:**
- **🚨 Blocking**: Must be fixed (security, bugs, data loss)
- **💡 Suggestion**: Should consider (performance, maintainability)
- **❓ Question**: Seeking understanding
- **📝 Nit**: Optional style preference (usually skip these)
- **✅ Praise**: Acknowledge good code

**Review Checklist:**
- [ ] Code is correct and logical
- [ ] Tests cover new code
- [ ] No security vulnerabilities
- [ ] Performance is acceptable
- [ ] Code is readable
- [ ] Error handling is appropriate
- [ ] Follows project conventions

## Pair Programming

### Roles

**Driver (typing):**
- Focus on implementation
- Think tactically
- Communicate what you're doing
- Ask for input

**Navigator (reviewing):**
- Think strategically
- Consider edge cases
- Look ahead to next steps
- Catch mistakes early
- Suggest improvements

### Best Practices
- Switch roles every 15-30 minutes
- Communicate continuously
- Stay engaged (both people)
- Take breaks together
- Discuss before major decisions
- Be patient with different styles
- Share keyboard/control equally

### Remote Pairing
- Use screen sharing effectively
- Have good audio setup
- Use collaborative editors (VSCode Live Share)
- Be more explicit in communication
- Check in frequently
- Share control easily

## Asynchronous Collaboration

### For Remote/Distributed Teams

**Documentation:**
- Write decisions and context down
- Keep wiki/docs updated
- Record meetings when helpful
- Use written communication well

**Status Updates:**
- Update ticket/issue status
- Leave clear handoff notes
- Document blockers
- Note what's done and what's next

**Example Handoff:**
```markdown
## Status Update - Feature X

**Completed:**
- API endpoint implemented (src/api/users.ts:45)
- Tests written and passing
- Database migration created

**In Progress:**
- Frontend integration (50% done)
- Working on form validation

**Blocked:**
- Waiting for design approval on error states
- Need API key for third-party service

**Next Steps:**
1. Complete form validation
2. Add loading states
3. Update documentation
```

## Knowledge Sharing

### Documentation
- Write clear README files
- Document architecture decisions (ADRs)
- Create runbooks for common tasks
- Comment complex code appropriately
- Write helpful commit messages

### Mentoring
- Pair program to teach
- Review code educatively
- Share resources and learnings
- Be patient and encouraging
- Provide context, not just answers

### Sharing Learnings
- Demo new features to team
- Share post-mortems of incidents
- Document solutions to problems
- Present at team meetings
- Write internal wiki articles

## Meeting Effectiveness

### Before Meetings
- Have clear agenda
- Share pre-reading materials
- Invite only necessary people
- Define expected outcomes

### During Meetings
- Start and end on time
- Stay on topic
- Take notes
- Identify action items with owners
- Summarize decisions

### After Meetings
- Share notes with team
- Follow up on action items
- Update documentation
- Send summary to stakeholders

## Giving Feedback

### SBI Framework
**Situation-Behavior-Impact:**

```
Situation: In yesterday's standup
Behavior: You interrupted other team members
Impact: They couldn't share their updates completely

Could you wait until others finish before jumping in?
```

### Feedback Best Practices
- Be timely (soon after event)
- Be specific and concrete
- Focus on behavior, not personality
- Be balanced (positive + constructive)
- Make it actionable
- Deliver critical feedback privately
- Follow up later

## Receiving Feedback

- Listen without interrupting
- Ask clarifying questions
- Don't be defensive
- Thank the person
- Reflect on the feedback
- Act on valid points
- Follow up on improvements made

## Conflict Resolution

### Handling Disagreements

**Technical Disagreements:**
1. Understand each perspective
2. Focus on facts and data
3. List pros/cons of each approach
4. Prototype if unclear
5. Defer to domain expert if needed
6. Document final decision
7. Commit once decided

**When to Escalate:**
- Can't reach consensus
- Significant impact or risk
- Need broader input
- Time-sensitive decision
- Outside team's authority

**Disagreement Etiquette:**
- Disagree respectfully
- Listen to understand
- Assume competence and good intent
- Focus on problem, not person
- Be willing to be wrong
- Know when to let go

## Cross-Functional Collaboration

### With Product Managers
- Understand business context
- Provide technical feasibility input
- Propose alternative solutions
- Communicate trade-offs clearly
- Give realistic estimates

### With Designers
- Understand design intent
- Provide early feasibility feedback
- Collaborate on user experience
- Communicate technical constraints
- Respect design decisions

### With QA/Testing
- Provide test environments
- Explain implementation details
- Collaborate on test strategies
- Fix bugs promptly
- Appreciate thorough testing

## Communication Channels

### Choose Appropriately

**Synchronous (Real-time):**
- Video call: Complex discussions, pair programming
- Chat: Quick questions, urgent issues

**Asynchronous:**
- Email: Formal communication, external parties
- Issues/Tickets: Feature requests, bugs, tracking
- PR comments: Code-specific discussion
- Wiki/Docs: Persistent knowledge, processes

### Channel Guidelines
- Use public channels when possible (more can help/learn)
- Use DMs for personal/sensitive topics
- @mention for specific people's input
- Use threads to organize discussions
- Respect do-not-disturb status

## Building Trust

### Trust-Building Behaviors
- **Be reliable**: Do what you say
- **Be transparent**: Share information
- **Be consistent**: Act predictably
- **Admit mistakes**: Take responsibility
- **Give credit**: Acknowledge others
- **Show competence**: Deliver quality work
- **Be respectful**: Value others' time
- **Be vulnerable**: Ask for help

## Remote Work Best Practices

### Communication
- Over-communicate status
- Be responsive during work hours
- Set and respect boundaries
- Use video when possible
- Document more than in-person

### Presence
- Keep calendar updated
- Communicate availability
- Join video with camera when possible
- Be present in meetings (no multitasking)

### Building Relationships
- Virtual coffee chats
- Participate in team building
- Share appropriately
- Show empathy
- Be human

## Collaboration Anti-Patterns

**Avoid:**
- **Hero culture**: Doing everything yourself
- **Gatekeeping**: Making it hard for others
- **Information hoarding**: Not sharing knowledge
- **Passive aggression**: Indirect criticism
- **Ghosting**: Not responding
- **Undermining**: Working against decisions
- **Bike-shedding**: Focusing on trivial issues

## Quick Reference: Good Practices

### Daily
- Check messages and respond
- Update ticket status
- Communicate blockers
- Help teammates when able

### Weekly
- Share learnings
- Give feedback
- Update documentation
- Reflect on processes

### Always
- Communicate clearly
- Be respectful
- Share knowledge
- Support teammates
- Focus on team success

## Remember

- Effective collaboration requires effort from everyone
- Clear communication prevents misunderstandings
- Feedback should be constructive and kind
- Document decisions and knowledge
- Help others succeed
- Celebrate team wins
- Continuous improvement
- Empathy and respect are foundational
