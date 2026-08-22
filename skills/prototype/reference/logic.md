# Logic Prototype

One self-contained HTML file that lets anyone drive a state model by clicking buttons. Use when the question is about **business logic, state transitions, or data shape** — things that look fine on paper but only feel wrong once pushed through real cases.

Because it's a single file with nothing to install, hand it to a non-developer (designer, PM, domain expert) and let them feel the model. It speaks their language, not the code's.

## Right shape when

- "Not sure this state machine handles X-then-Y."
- "Does the data model represent case ...?"
- "Want to feel out what the API should look like before writing it."
- Anything where someone wants to press buttons and watch state change.

If the question is "what should this look like", use [ui.md](ui.md) instead.

## Build

### 1. State the question
One paragraph at the top of the demo, visible — not just a comment. A prototype answering the wrong question is pure waste.

### 2. Isolate the logic in a portable module
The answering logic lives in one `<script>` block as a small **pure module** — liftable straight into the real codebase later:

- Pure reducer `(state, action) => state` — discrete events, single state value
- Explicit state machine — when "which actions are legal right now" is part of the question
- Pure functions over a plain data type — no implicit current state
- Class/module with clear method surface — logic genuinely owns ongoing internal state

Pick whichever fits the question, not whichever is easiest to wire up. Keep it pure: no DOM, no `document`, no button handlers inside it. The page calls in; nothing flows back.

### 3. The page
Plain HTML/CSS/JS: no framework, no bundler, no server, all inline — opens by double-click, survives email. Written for a non-developer: labels and states read like the business, not like code. Top-to-bottom hierarchy:

1. **Title + one-line explanation** of what this explores
2. **Current state**: readable panel (labelled fields, not raw JSON), re-rendered after every click; call out what just changed where it helps
3. **Free-play buttons**: one per action, always available, any order
4. **Guided walkthroughs**: tabbed scenarios — short plain-language setup plus ordered real buttons to press. Each starts from a known initial state so it runs identically every time

Choose scenarios for the awkward cases hard to reason about on paper: happy path, tricky edge case, an attempt at something illegal. Clean typography, generous spacing, one accent colour — nothing competing with the state and buttons.

## Anti-patterns

- **No tests.** A prototype needing tests isn't a prototype.
- **No real database.** In-memory unless persistence is the question itself.
- **Don't generalise.** One question per prototype; no "what if we support X later".
- **Never blur page and logic.** If the module touches DOM/handlers, it's no longer liftable.
- **No frameworks/bundlers/servers.** A dev server defeats "shareable".
- **HTML shell never ships.** Only the validated module lifts into production.
