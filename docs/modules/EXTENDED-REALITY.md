# Module: Extended Reality (XR)

**Phase:** 6  
**Slug:** `extended-reality`  
**Status:** not started  

---

## What it is / how to think about it

Extended reality (XR) is the umbrella term for VR, AR, and MR — computing at the boundary between the physical and digital worlds. It's the next major platform shift after mobile: if mobile computing put a screen in your pocket, spatial computing puts a screen over your eyes (and eventually, everywhere).

**Mental model:** Every display medium creates a new set of design constraints and affordances. The web freed us from the desktop. Mobile freed us from the desk. XR frees us from the screen — but introduces a new set of hard constraints: field of view, latency, vergence-accommodation conflict, and the problem of placing persistent digital objects in a physical world that keeps changing.

---

## Prerequisites
- HCI + Research Areas module
- Mobile + Ubiquitous Computing module (recommended first)

---

## Best resources

**Primary:**
1. [Apple Vision Pro Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/designing-for-visionos) — the most detailed, current spatial computing design guide; even if you don't build for Vision Pro, the principles are universal
2. [Michael Abrash — Ramblings in Realtime](https://www.chinchetti.com/files/Books/Abrash%27s%20Black%20Book%20of%20Graphics.pdf) — the deepest technical explanation of what makes VR hard (latency, persistence, optics); older but foundational

**Supporting:**
- [John Carmack — Oculus Connect keynotes](https://www.youtube.com/results?search_query=john+carmack+oculus+connect) — the most technically honest talks on VR's unsolved problems
- [Meta Quest Developer Documentation](https://developer.oculus.com/documentation/) — practical platform reference
- [IEEE VR Conference Proceedings](https://ieeevr.org/) — research venue for XR; browse recent papers

**YouTube:**
- [The History and Future of VR — Palmer Luckey](https://www.youtube.com/watch?v=BJFM5e4P4vk) (45 min)
- [Apple Vision Pro: Spatial Design — WWDC23](https://developer.apple.com/videos/play/wwdc2023/10072/) (30 min)
- [Why VR is Hard — Two Minute Papers](https://www.youtube.com/watch?v=_0Uk6CWUNAY) (10 min; good intro)

---

## Core concepts

### The reality-virtuality continuum
- Milgram's continuum: Real Environment → Augmented Reality → Mixed Reality → Augmented Virtuality → Virtual Environment
- VR: fully synthetic world; user is immersed, physical reality is occluded
- AR: digital overlays on the physical world; user remains present in physical space
- MR: digital objects that interact with physical objects (anchor to surfaces, occlude correctly)
- Passthrough AR: cameras on a VR headset show the real world with digital overlays (Meta Quest 3, Apple Vision Pro)

### Presence and immersion
- Presence: the feeling of "being there" in the virtual environment
- Immersion: the technical fidelity of the system (resolution, tracking, audio, haptics)
- High immersion doesn't guarantee presence; low immersion can still produce presence
- Presence breaks: any latency spike, tracking failure, or visual anomaly can collapse presence
- Presence is desirable for entertainment, training, therapy; may be undesirable for productivity (you want to remain aware of your physical context)

### Degrees of freedom (DoF)
- 3DoF: tracks rotation only (look around); older mobile VR (Google Cardboard)
- 6DoF: tracks rotation + position (look around and walk around); required for convincing VR
- Controller tracking: inside-out (cameras on headset track controllers in space) vs. outside-in (external base stations)

### Latency and the motion-to-photon problem
- Motion-to-photon latency: time from head movement to updated pixels on display
- Human perceptual threshold: ~20ms; above this, users feel sick (vestibular-visual mismatch)
- Reprojection: synthesize intermediate frames to reduce perceived latency
- This is why untethered standalone headsets (Quest) are a major engineering achievement — doing this wirelessly at low latency is hard

### Vergence-accommodation conflict (VAC)
- In the real world: when you focus on a near object (accommodation), your eyes converge (vergence) — these are coupled
- In current displays: virtual depth is simulated by offset images (stereo), but the display is at a fixed physical distance (accommodation is fixed)
- Result: eye strain, headaches, limits on comfortable VR session length
- Solutions in development: varifocal displays, light field displays, retinal projection

### Spatial input and interaction
- No touchscreen in 3D space; input is fundamentally different
- Hand tracking (Meta Quest, Vision Pro): map hand pose to actions; no controller required
- Eye tracking (Vision Pro): look at a target, then pinch to select; eyes as pointing device
- Voice: natural in immersive environments; difficult in public AR
- Key design principle: direct manipulation (reach out and touch) is more intuitive than ray-casting (point a laser at objects)

### Designing for XR
- Typography: legible at all depths; avoid small text at distance
- Spatial layout: don't place content at extreme angles or distances; use a comfortable "bubble" around the user
- Transitions: hard cuts disorient in VR; use fades or spatial transitions
- Anchoring in AR: digital objects should behave physically (shadows, occlusion, scale with distance)
- Accessibility: not everyone can use hand tracking; always provide fallback input

### Current platforms and their bets
| Platform | Bet |
|---|---|
| Apple Vision Pro | Productivity + media consumption; passthrough AR; premium |
| Meta Quest 3 | Gaming + social; standalone; broad market price point |
| Microsoft HoloLens | Enterprise AR (manufacturing, surgery, maintenance) |
| Magic Leap 2 | Enterprise AR; field of view advantage |

---

## Exercises

**Set 1 — Platform survey (45 min):**
Read the Apple Vision Pro HIG (design principles section) and the Meta Quest developer best practices doc.
Compare:
- How do they think about user input?
- How do they handle the transition between virtual and real?
- What constraints do they each acknowledge?
Save to `docs/reading/XR-PLATFORM-COMPARISON.md`.

**Set 2 — Experience analysis (30 min):**
If you have access to any XR device (Vision Pro, Quest, even a phone-based AR app), do this:
Try one experience critically — any app or game. While using it, note:
- When does presence hold? When does it break?
- What input method is being used? Is it intuitive?
- What latency or tracking failures do you notice?
- What would make it significantly better?

If no device is available, watch two demo videos (one VR, one AR) and do the same analysis from the observer perspective.
Save to `docs/reading/XR-EXPERIENCE-ANALYSIS.md`.

**Set 3 — Interaction design challenge (45 min):**
Design the interaction for one of:
- A virtual meeting room where 4 remote people collaborate on a shared whiteboard
- An AR overlay for a surgeon seeing patient vitals during a procedure
- A VR onboarding experience for a complex enterprise software tool

Cover: what input method, how objects are placed/moved, what happens when the model is wrong (misrecognized gesture), how to handle latency gracefully.
Save to `docs/reading/XR-INTERACTION-DESIGN.md`.

**Set 4 — Research survey (30 min):**
Browse [IEEE VR 2024 proceedings](https://ieeevr.org/2024/program/papers/) or [ISMAR](https://ismar.net/). Find one paper that interests you. Read the abstract, intro, and conclusion.
- What problem are they solving?
- What was the key insight?
- What does this mean for product development in the next 3 years?
Save to `docs/reading/XR-RESEARCH-NOTES.md`.

---

## Checks — you understand this when you can:
- [ ] Explain the reality-virtuality continuum with an example at each point
- [ ] Describe motion-to-photon latency and why 20ms is the threshold
- [ ] Explain the vergence-accommodation conflict and why it causes fatigue
- [ ] Compare 3DoF and 6DoF tracking and explain why 6DoF is required for convincing VR
- [ ] Critique an XR interface using spatial design principles

---

## Artifacts to commit
- [ ] `docs/reading/XR-PLATFORM-COMPARISON.md`
- [ ] `docs/reading/XR-EXPERIENCE-ANALYSIS.md`
- [ ] `docs/reading/XR-INTERACTION-DESIGN.md`
- [ ] `docs/reading/XR-RESEARCH-NOTES.md`
- [ ] Glossary entries: XR, VR, AR, MR, presence, immersion, 6DoF, motion-to-photon latency, vergence-accommodation conflict, passthrough AR
- [ ] Log entry in `docs/LOG.md`
