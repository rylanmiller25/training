# Module: Mobile + Ubiquitous Computing

**Phase:** 6  
**Slug:** `mobile-ubiquitous`  
**Status:** not started  

---

## What it is / how to think about it

Ubiquitous computing is Mark Weiser's 1991 vision: computing woven into everyday objects and environments, invisible until needed, serving people without demanding their full attention. Mobile computing is the first major realization of that vision — a general-purpose computer you carry everywhere. Together, they represent the shift from "sitting at a computer" to "computers everywhere, all the time."

**Mental model:** Desktop computing treats the user as someone who comes to the computer. Ubiquitous computing treats the computer as something that comes to the user — it knows where they are, what they're doing, and what they're likely to need next. The design challenge is using that context to be helpful without being intrusive. Calm technology: inform at the periphery, move to the center only when needed.

---

## Prerequisites
- HTTP + APIs module (Phase 1) — mobile apps are API clients
- HCI + Research Areas module (Phase 6)

---

## Best resources

**Primary:**
1. [Mark Weiser — The Computer for the 21st Century (1991)](https://www.lri.fr/~mbl/Stanford/CS477/papers/Weiser-SciAm.pdf) — the foundational paper; short and worth reading in full
2. [Apple Human Interface Guidelines for iOS](https://developer.apple.com/design/human-interface-guidelines/) — the most comprehensive, current guide to mobile design principles and patterns

**Supporting:**
- [Google Material Design](https://m3.material.io/) — Android's design system; complementary to Apple HIG
- [UbiComp Conference Proceedings](https://ubicomp.org/) — premier research venue for ubiquitous computing
- [Calm Technology — Amber Case](https://calmtech.com/) — modern extension of Weiser's principles; practical design guidelines

**YouTube:**
- [Mark Weiser: Ubiquitous Computing — Stanford lecture (recorded)](https://www.youtube.com/watch?v=PvRME_g3PVNU) (archive; historical context)
- [The History of Mobile Design — Google I/O](https://www.youtube.com/watch?v=_MrMlJ6PUKE) (30 min)
- [Context-Aware Computing — MIT lecture](https://www.youtube.com/watch?v=5BcCauxDn3U) (45 min)

---

## Core concepts

### The ubiquitous computing vision
- Weiser's three device scales: tabs (inch-scale, like phones), pads (foot-scale, like tablets), boards (yard-scale, like displays)
- "The most profound technologies are those that disappear" — they become infrastructure, taken for granted
- Calm technology: periphery vs. center of attention; good ubiquitous computing lives in the periphery and moves to center only when needed
- Current realization: smartphones, smartwatches, smart speakers, always-on cameras, ambient displays

### Context awareness
- Context: who, where, when, what, why — any sensor-derived information about the user's situation
- Location: GPS, WiFi triangulation, cell towers, indoor positioning (Bluetooth beacons)
- Activity recognition: accelerometer + gyroscope → walking, running, driving, stationary
- Social context: nearby devices (Bluetooth), calendar, communication patterns
- Context use cases: show umbrella reminder when it's about to rain, surface transit directions when arriving at a transit stop
- Privacy implication: context data is deeply personal; always ask why you need it and how long to retain it

### Mobile constraints and design patterns
**Hardware constraints:**
- Battery: everything is a battery tradeoff (location polling, networking, compute)
- Screen size: information density limits; one primary action per screen
- Connectivity: intermittent; design offline-first with sync when connected
- Input: touch, voice, gestures — no hover state, no right-click, fat-finger problem

**Design patterns specific to mobile:**
- Progressive disclosure: reveal complexity only when needed (one-screen-at-a-time flows)
- Thumb zone: reachable vs. stretch areas on a phone screen; primary actions bottom-center
- Swipe gestures: left/right for navigation; pull-to-refresh; swipe to dismiss
- System-level conventions (back button, share sheet, notification tray) — use them; don't reinvent

### Notifications: the highest-stakes mobile design decision
- Push notifications are the most powerful and most abused affordance in mobile
- Each notification is a bid for attention; too many bids → users mute everything
- Good notification criteria: timely (now vs. later matters), actionable (user can do something), personal (relevant to this specific user)
- Notification design: can the user understand and act on this notification without opening the app?
- Dark pattern: notification spam to drive engagement metrics at the cost of user trust

### Wearables and the body-worn form factor
- Smartwatches: glanceable information (2–5 second interactions); complications on watch faces; notification triage
- Earbuds: audio as ambient computing; spatial audio; voice as primary input
- Haptics: notifications that don't require visual attention (Apple Watch tap patterns)
- Health sensors: heart rate, blood oxygen, ECG, accelerometer for falls; raises privacy and medical regulatory questions

### IoT and ambient computing
- Internet of Things: everyday objects with embedded sensors, actuators, and network connectivity
- Smart home: thermostats (Nest), lights (Hue), speakers (HomePod/Echo), doorbells (Ring)
- Design for non-experts: most IoT users are not technical; UX must work without configuration
- Security: IoT devices are often poorly secured; default passwords, no update mechanisms, long deployment lifetimes
- The "smart" trap: adding connectivity to everything creates complexity without proportionate value

### Offline-first architecture
- Mobile networks are unreliable; design so the app works offline and syncs when connected
- Conflict resolution: what happens when two devices edited the same data while offline? (last-write-wins, CRDT, manual merge)
- Local-first: compute and store on device, sync to cloud as secondary — faster, more private, works offline
- Progressive Web Apps: web apps with offline support via service workers; installable on home screen

---

## Exercises

**Set 1 — Context audit (30 min):**
Read Mark Weiser's 1991 paper. Then audit one app you use daily:
- What context does it already use? (location, time, device type, past behavior)
- What context could it use that it doesn't?
- What context would be useful but crosses a privacy line?
- Describe one feature addition that would use context to be genuinely helpful without being creepy.
Save to `docs/reading/CONTEXT-AUDIT.md`.

**Set 2 — Notification design (30 min):**
Review the notification history on your phone for one day. For each app that sent you a notification:
- Was it timely? Actionable? Personal?
- Did you act on it or dismiss it?
- What would have made it better or made you want it at all?

Then design a notification strategy for the experimentation platform mobile companion:
- What events should trigger a notification? (experiment reaches significance, anomaly detected, daily summary)
- What's the notification copy?
- When should notifications be batched vs. immediate?
Save to `docs/reading/NOTIFICATION-DESIGN.md`.

**Set 3 — Offline-first design (45 min):**
Design the offline behavior for a mobile app that lets users monitor and manage their running experiments:
- What data must be available offline? (recent results, experiment status)
- What actions can be taken offline? (view only? mark as complete? add notes?)
- What happens when offline changes conflict with server state?
- How does the UI communicate online vs. offline status?
Save to `docs/reading/OFFLINE-FIRST-DESIGN.md`.

**Set 4 — UbiComp research survey (30 min):**
Browse [UbiComp 2024 proceedings](https://ubicomp.org/ubicomp2024/). Find one paper on a topic you care about (activity recognition, wearables, smart environments, privacy in IoT). Read the abstract and introduction.
- What is the research problem?
- What did they build or study?
- What would change about a product you know if this research were widely applied?
Save to `docs/reading/UBICOMP-PAPER-NOTES.md`.

---

## Checks — you understand this when you can:
- [ ] Explain Mark Weiser's "calm technology" concept and give a modern example
- [ ] List 5 types of context a mobile device can sense and a use case for each
- [ ] Explain the three criteria for a good push notification
- [ ] Describe what offline-first means and name one conflict resolution strategy
- [ ] Compare wearable and phone design constraints and explain the design implications

---

## Artifacts to commit
- [ ] `docs/reading/CONTEXT-AUDIT.md`
- [ ] `docs/reading/NOTIFICATION-DESIGN.md`
- [ ] `docs/reading/OFFLINE-FIRST-DESIGN.md`
- [ ] `docs/reading/UBICOMP-PAPER-NOTES.md`
- [ ] Glossary entries: ubiquitous computing, calm technology, context awareness, offline-first, IoT, wearable, progressive web app, thumb zone
- [ ] Log entry in `docs/LOG.md`
