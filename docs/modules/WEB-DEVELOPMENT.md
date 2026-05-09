# Module: Web Development for AI Products

**Phase:** 6  
**Slug:** `web-development`  
**Status:** not started  

---

## What it is / how to think about it

This module is not about learning to code a website. It's about developing the vocabulary, design literacy, and briefing skill to direct an AI agent — specifically Claude Code — to build an interactive, effective, modern website that accurately represents who you are and what you've built.

The gap between "I asked the agent to build a website" and "I got a website I'm proud of" is almost entirely a briefing problem. Agents can execute well; they need to know what "well" means for your specific context. That requires you to: (1) have genuine opinions about design, (2) know enough about the technical stack to specify constraints, and (3) be able to evaluate what comes back and give precise feedback.

**Mental model:** Think of yourself as the creative director and the agent as the designer/developer. A creative director who can't articulate what good looks like will get generic output. A creative director who can say "the hero section needs more breathing room, the type hierarchy is wrong, and the card hover state should be more subtle" gets something worth shipping.

---

## Prerequisites
- `figma` — you should already think in terms of layout, hierarchy, and components before this module
- `prompt-eng` — directing agents is a form of prompt engineering; apply that discipline here
- Phase 5 largely complete — your work should exist before you design the site that presents it

---

## Best resources

**Design references:**
- [Refactoring UI](https://www.refactoringui.com/) — the best practical guide to making things look good without a design background; read the free excerpts; buy the book if you want to go deep
- [Anthrop\ic's design language](https://anthropic.com) — study the actual Anthropic website for AI product aesthetic: sparse, text-first, confident, no stock photos
- [Linear.app](https://linear.app) — benchmark for modern B2B SaaS design: bold typography, deep color, fast animations, very little decoration
- [Vercel.com](https://vercel.com) — technical product design done well: dark mode-first, code-forward, performance as a value

**Technical stack reference:**
- [Next.js documentation](https://nextjs.org/docs) — the framework you'll use; understand the file-based routing and the distinction between server and client components
- [Tailwind CSS](https://tailwindcss.com/docs) — how to communicate style to the agent using utility classes
- [Framer Motion](https://www.framer.com/motion/) — the animation library; know what it can do so you can ask for it

**Agent direction:**
- [v0.dev](https://v0.dev) — Vercel's component generator; useful for generating UI component starting points before asking Claude Code to integrate them
- Study the output of your own agent interactions — the feedback you give is the most important learning

---

## Core concepts

### The modern AI product aesthetic

AI product websites in 2025–2026 share a recognizable visual language. Understanding it lets you describe what you want and recognize when you're getting it.

**What it looks like:**
- **Sparse and text-forward.** The content carries the weight. No filler images, no decorative gradients for their own sake. White space is intentional, not empty.
- **Bold, confident typography.** Large headlines, clear hierarchy, usually a single sans-serif typeface (Inter, Geist, or similar). Type does most of the visual work.
- **Restrained color palette.** Often near-monochromatic with one accent. Dark mode as a first-class citizen, not an afterthought. Subtle use of the accent color to direct attention.
- **Motion that communicates, not motion that decorates.** Subtle entrance animations, hover states that feel responsive, transitions that orient the user. Nothing that spins, pulses, or bounces for its own sake.
- **Data and output as design elements.** For technical products — code blocks, charts, statistical outputs — shown as part of the design, not hidden behind a screenshot. If your platform generates HTE results, show a real one.
- **Trust signals embedded naturally.** For a portfolio: specific numbers, named artifacts, concrete work. Not "I'm passionate about AI" but "I built a causal inference engine that surfaces heterogeneous treatment effects for startup pricing experiments."

**What to avoid:**
- Hero images of people at computers, stock photography of any kind
- Gradients that are purely decorative (gradient text on every heading is a cliché)
- Excessive dark/light mode toggles as personality (pick one and commit)
- Testimonials before you have real ones
- Vague mission statements as the first thing on the page ("Empowering the future of...")
- Any animation that takes longer than 300ms or that a user might need to wait for

### Understanding the technical stack well enough to direct the agent

You don't need to write this code. You need to understand it well enough to specify what you want and evaluate what you get.

**Next.js (the framework):**
- A React framework with file-based routing — each file in the `app/` folder becomes a URL
- Server components (fast, rendered on the server, good for static content) vs. client components (interactive, run in the browser, needed for animations and user input)
- Know this distinction because it affects performance: if the agent makes everything a client component, the site will be slower than it needs to be
- Vercel deploys Next.js natively in one command; this is your deployment target

**Tailwind CSS (the styling system):**
- Utility classes that describe exactly how something looks: `text-2xl font-bold text-gray-900 leading-tight`
- The agent speaks Tailwind fluently; you can specify styles by describing the visual outcome and the agent will translate
- Know that spacing uses a scale (`p-4` = 16px, `p-8` = 32px) and that this scale is important for visual consistency
- Responsive prefixes: `md:text-xl` means "text-xl on medium screens and up"

**Framer Motion (animations):**
- The standard animation library for React; the agent knows it well
- Key patterns: `initial` (starting state), `animate` (ending state), `transition` (how to get there)
- The animations you'll use most: fade-in on scroll (`whileInView`), stagger children (each element enters slightly after the previous), hover scale (`whileHover`)

**TypeScript:**
- All code should be TypeScript, not JavaScript — the agent will use TypeScript by default in a Next.js project, which is correct

### How to write an effective brief for the agent

The brief is what you give Claude Code before it writes any code. A good brief has four layers:

**1. Vision statement (2–3 sentences):**
What is this site, who is it for, what should someone feel when they see it? Be specific about the feeling: "technical credibility without arrogance, the sense that this person builds real things" is more useful than "professional and modern."

**2. Content inventory:**
What pages, what sections, what content? List every piece of content that needs to exist. The agent cannot invent your content — it needs to know what goes where. Include actual text for headlines and key copy; don't say "a headline about the platform" when you can write the actual headline.

**3. Visual reference and constraints:**
- "Model the typographic style after Linear.app — bold headline, clear hierarchy, generous line height"
- "Dark mode as the default; a clean off-white for the light mode"
- "Use Inter as the typeface throughout"
- "Animations should be subtle — 200–300ms fade-ins on scroll, nothing faster or slower"
- Link to specific pages you want referenced: "the hero section should feel like vercel.com/home but with more whitespace"

**4. Technical constraints:**
- "Next.js 14 App Router, TypeScript, Tailwind CSS, Framer Motion"
- "Deploy target is Vercel"
- "PostHog analytics installed on every page using the PostHog Next.js SDK"
- "No external image dependencies — all images are local or from Unsplash (specify the exact Unsplash photo ID)"
- "Mobile-first — every layout must work at 375px width before being adapted for desktop"

### Giving feedback to the agent

The quality of your feedback determines the quality of the next iteration. Vague feedback produces vague improvements.

**Bad feedback:** "The hero section doesn't look right."
**Good feedback:** "The hero section headline is too small relative to the subheading — the hierarchy is inverted. Increase the headline to at least `text-5xl` on desktop, reduce the subheading to `text-lg`, and add more vertical padding above and below the section (`py-32` minimum)."

**Bad feedback:** "Can you make it more modern?"
**Good feedback:** "Add a subtle entrance animation to the headline and subheading — they should fade in and slide up by 12px, staggered by 150ms between them. Use Framer Motion `whileInView` with `once: true`."

**Bad feedback:** "The colors are off."
**Good feedback:** "The background is too warm — it should be `#0a0a0a` (near-black), not `#1a1512`. The accent color is too bright; pull it to `#6366f1` instead of the current `#8b5cf6`."

When something is right, say so explicitly: "The card hover states are exactly right — keep those." The agent has no memory across sessions; telling it what to preserve is as important as telling it what to change.

### The pages you need

For your personal portfolio site:

**Home / Landing:**
- Hero: your name, one-line positioning statement, the clearest possible description of what you've built
- Featured work: the platform (primary), research (secondary)
- Writing preview: 2–3 recent pieces with dates
- Minimal footer: links, contact

**Platform:**
- What it is and why it exists (two versions, toggled or linked — technical and non-technical)
- Live demo or screenshots with annotations
- Link to GitHub
- Technical architecture overview (for technical readers)

**Research:**
- Your existing academic work, presented for two audiences
- Link to papers if publicly available

**Writing / Blog:**
- All content pieces from `docs/writing/`, each with a reading time estimate and the "who this is for" framing (technical or non-technical)

**About:**
- Who you are, what you want to work on, where you've been
- Short. Direct. No objectives section. No "passionate about" language.

### Performance and accessibility basics

These are constraints to include in your brief so the agent builds them in from the start.

**Performance:**
- Images should use Next.js `<Image>` component (automatic optimization, lazy loading, correct sizing)
- No layout shift — all elements should have explicit dimensions or `min-height` so the page doesn't jump as content loads
- Fonts loaded via `next/font` (not a `<link>` tag) for zero-flash font loading
- Aim for a Lighthouse performance score above 90

**Accessibility:**
- Every `<img>` needs an `alt` attribute
- Color contrast: text on background must meet WCAG AA (4.5:1 ratio for body text)
- Interactive elements (links, buttons) must be keyboard-navigable — the agent should use `<button>` and `<a>` not `<div onClick>`
- Heading hierarchy: `h1` once per page, `h2` for sections, `h3` for subsections — never skip levels

---

## Exercises

**Set 1 — Design audit (45 min):**
Study three websites from the AI product world. For each:
- Screenshot the hero section, one content section, and the footer
- Write 3 things they're doing well (specific: "the typographic scale is well-calibrated — the h1 is 2× the h2 which is 1.5× the body")
- Write 1 thing you'd change and why
- Identify the design pattern you most want to bring to your own site

Choose three from: Anthropic, Linear, Vercel, Perplexity, Harvey, Cursor, Notion.
Save to `docs/reading/DESIGN-AUDIT.md`.

**Set 2 — Write your site brief (1 hour):**
Write the full brief for your personal website using the four-layer structure:
- Vision statement: what should someone feel when they land on this site?
- Content inventory: every page, every section, the actual headline copy (not placeholder)
- Visual reference and constraints: specific sites to reference, typeface, color palette, animation style
- Technical constraints: stack, deployment target, analytics, performance requirements

This brief is what you hand to Claude Code. Make it specific enough that you could hand it to a human designer and they'd know what to build.
Save to `docs/projects/WEBSITE-BRIEF.md`.

**Set 3 — Build the home page (90 min with Claude Code):**
Using your brief from Set 2, build the home page with Claude Code assistance. Apply the AI prototyping discipline from `prompt-eng` Exercise Set 5:
- Write explicit success criteria before starting
- Log each major prompt and the output
- Note what feedback you gave and what changed
- Measure: does the page look like what you briefed?

Save the page code to `src/website/` and document the process in `docs/reading/WEBSITE-BUILD-LOG.md`.

**Set 4 — Responsive and accessible review (30 min):**
With the home page built:
- Open Chrome DevTools, simulate iPhone 12 Pro (390px) — does it work?
- Run Lighthouse (Chrome DevTools → Lighthouse tab) — what's the performance and accessibility score?
- Check the color contrast on body text using the DevTools accessibility inspector
- Fix the three most impactful issues the audit surfaces

Document what you found and what you changed in `docs/reading/WEBSITE-BUILD-LOG.md` (append, don't replace).

---

## Checks — you understand this when you can:
- [ ] Describe the modern AI product design aesthetic in specific terms (not just "clean and minimal")
- [ ] Write a four-layer website brief that a human designer or Claude Code could execute from
- [ ] Give precise, actionable feedback on a page the agent produces — specific enough that the agent knows exactly what to change
- [ ] Explain the difference between a server component and client component in Next.js, and why it matters for performance
- [ ] Explain what Tailwind utility classes are and specify a visual change using them
- [ ] Run a Lighthouse audit and identify the top three things to fix

---

## Artifacts to commit
- [ ] `docs/reading/DESIGN-AUDIT.md`
- [ ] `docs/projects/WEBSITE-BRIEF.md`
- [ ] `src/website/` — home page initial build
- [ ] `docs/reading/WEBSITE-BUILD-LOG.md`
- [ ] Glossary entries: server component, client component, Tailwind CSS, Framer Motion, Core Web Vitals, WCAG, layout shift, utility-first CSS
- [ ] Log entry in `docs/LOG.md`
