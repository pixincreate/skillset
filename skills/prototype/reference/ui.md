# UI Prototype

Generate several **radically different** UI variants on a single route, switchable from a floating bottom bar. User flips between them, picks one (or steals parts of each), throws away the rest.

If the question is about logic/state rather than looks, use [logic.md](logic.md).

## Right shape when

- "What should this page look like?"
- "A few options for this dashboard before committing."
- "Try a different layout for the settings screen."
- Any time the user would otherwise spend a day comparing vague mockups in their head.

## Prefer embedding over a new page

Variants are much easier to judge against the rest of the app: real header, sidebar, data, density. An isolated route is a vacuum — everything looks fine alone.

- **Embedded (default)**: render on the existing route, gated by `?variant=` search param. Existing fetching/params/auth stay; only rendering swaps. Same applies if the thing would naturally live inside an existing page (new dashboard section, new settings card).
- **Throwaway route (last resort)**: only when there's genuinely no host page. Follow existing routing conventions, name it so it's obviously a prototype (`/prototype/...`). Before committing, sanity-check: is there really nothing to embed into?

## Build

1. **State the plan, pick N.** Default **3**, cap at 5 (beyond that it's noise). One line at the top of the file/route: *"Three variants of the settings page, `?variant=`, on `/settings`."*

2. **Make variants structurally different.** Different layout, information hierarchy, primary affordance — not different colours. Three tweaked card grids is wallpaper. If two drafts come out similar, redo one with explicit constraints. Each respects the project's styling system (Tailwind/shadcn/MUI/plain CSS) with clear names: `VariantA`, `VariantB`, ...

3. **Wire a switcher** on the route:

   ```tsx
   // pseudo-code — adapt to the framework
   const variant = searchParams.get('variant') ?? 'A';
   return (
     <>
       {variant === 'A' && <VariantA {...data} />}
       {variant === 'B' && <VariantB {...data} />}
       {variant === 'C' && <VariantC {...data} />}
       <PrototypeSwitcher variants={['A','B','C']} current={variant} />
     </>
   );
   ```

4. **Floating bottom bar**: fixed bottom-centre, visually distinct from the page (high-contrast pill). Left/right arrows cycle (wrapping), label shows key + name (`B (Sidebar layout)`), arrows update the URL param via the router (shareable, reload-stable), keyboard ← → works except while typing in inputs/textareas/contenteditable. Gate it out of production builds (`NODE_ENV !== 'production'` or equivalent). One shared component.

5. **Hand off.** Surface the URL + variant keys. The valuable feedback is usually *"header from B, sidebar from C"* — that's the actual design.

6. **Capture.** Fold the winner into the real page; remove losers + switcher from main; commit the full set to a throwaway branch as the primary source.

## Anti-patterns

- **Colour/copy-only differences.** That's a tweak, not a prototype.
- **Shared `<Layout>`.** Kills the point; each variant must be free to throw out structure.
- **Real mutations.** Read-only; point writes at stubs.
- **Shipping prototype code as-is.** It was written without tests or error handling — rewrite properly when folding in.
