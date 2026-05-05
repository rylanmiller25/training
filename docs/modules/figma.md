# Module: Figma Fundamentals

**Phase:** 3 (Weeks 13–22) — integrated tool module  
**Slug:** `figma`  
**Status:** not started  
**Estimated time:** 4–5 hours

---

## What it is / how to think about it

Figma is the industry-standard design tool for UI/UX design. As a PM or engineer, you don't need to design screens from scratch — but you need to read designs fluently, leave useful comments, understand what's feasible, and know how handoff works so you can collaborate with designers without friction.

**Mental model:** Figma is a shared canvas. Frames are screens. Components are reusable design building blocks (like React components). Auto-layout makes frames resize intelligently. Figma files are the source of truth for UI — everything that gets built starts here.

---

## Prerequisites
- None. Exposure to any web product helps with intuition.

---

## Best resources

**Primary:**
1. [Figma official tutorials](https://help.figma.com/hc/en-us/categories/360002051613-Get-started) — interactive, in-product
2. [Figma for Developers – Figma](https://www.figma.com/developers/) — specifically the handoff/inspect section

**Supporting:**
- [DesignCode – Figma course](https://designcode.io/figma-handbook) — practical, project-based
- [Refactoring UI](https://www.refactoringui.com/) — book on UI design principles for non-designers

**YouTube:**
- [Figma tutorial for beginners – Figma](https://www.youtube.com/watch?v=FTFaQWZBqQ8) (25 min — official)
- [Figma for developers – DesignCode](https://www.youtube.com/watch?v=B242nuM3y2s) (30 min)
- [Design systems in Figma – Figma](https://www.youtube.com/watch?v=EK-pHkc5EL4) (20 min)

---

## Core concepts

### Interface anatomy
- **Frames:** containers for screens/components; have fixed or responsive sizing
- **Groups:** loose collections of layers (no layout logic)
- **Components:** reusable building blocks; instances inherit changes from the "master" component
- **Variants:** component states in one container (button: default, hover, disabled, loading)
- **Auto-layout:** makes frames resize based on content (like flexbox in CSS)

### Design systems
- **Styles:** reusable colors, text styles, shadows, effects — the design system's tokens
- **Component library:** shared set of components (button, input, modal, card)
- **Design tokens:** the bridge between design (hex colors, font sizes) and code (CSS variables)
- In production: designers and engineers share a language via tokens

### Handoff + inspect
- **Inspect panel:** view exact CSS properties, spacing, colors, fonts for any element
- **Export:** assets as PNG, SVG, or PDF
- **Dev mode:** Figma's mode specifically for engineers — shows specs, measurements, code snippets

### Reading a design file (practical skills)
- Navigate layers panel to understand structure
- Check constraints (how element resizes with screen)
- Check component variants to understand all states
- Hover over elements in Inspect mode to get measurements and styles
- Leave a comment (`C` key) pinned to a specific element for async collaboration

### Interaction and prototyping
- Connect frames with arrows to simulate navigation
- Add transitions (fade, push, slide)
- Test in presentation mode (play button)
- Useful for: getting stakeholder approval before building; testing user flows

---

## Exercises

**Set 1 — Read an existing design (30 min):**
Open any public Figma community file (figma.com/community — search "design system").
1. Identify: frames, components, variants, auto-layout containers
2. Inspect a button component: what are its variants? What are its exact dimensions and colors?
3. Find the text styles: what font families and sizes are defined?

**Set 2 — Create a simple screen (45 min):**
In your own Figma file, design a minimal UI:
- A login screen: email input, password input, submit button, "forgot password" link
- Use auto-layout for the form container
- Use components for the button (with at least 2 variants: default, loading)

**Set 3 — Inspect for development (20 min):**
In Dev Mode or the Inspect panel on your login screen:
1. Get the exact CSS for the button (color, border-radius, padding, font)
2. Export the logo or an icon as SVG
3. Write out (in `docs/reading/figma-inspect-notes.md`): what information would an engineer need to implement this screen? Does Figma provide all of it?

**Set 4 — Prototype flow (20 min):**
Link your login screen to a "dashboard" (just a frame with the text "Welcome!").
Add a transition (smart animate or fade) triggered by clicking the button.
Present the prototype. This is how you test a flow before writing code.

---

## Checks — you understand this when you can:
- [ ] Navigate a Figma file and identify frames, groups, and components
- [ ] Use the Inspect panel to read CSS properties, spacing, and colors
- [ ] Explain what auto-layout does and why it matters for responsive design
- [ ] Explain what design tokens are and why they bridge design and code
- [ ] Leave a useful, pinned comment on a design during review

---

## Artifacts to commit
- [ ] `docs/reading/figma-inspect-notes.md`
- [ ] Share link to your Figma practice file in `docs/projects/figma-practice.md`
- [ ] Log entry in `docs/log.md`
