# Module: Robotics + Embodied AI (Survey)

**Phase:** 6  
**Slug:** `robotics`  
**Status:** not started  

---

## What it is / how to think about it

Embodied AI is AI that operates in and acts on the physical world — robots, autonomous vehicles, drones, and AI-powered physical systems. It's the frontier where language model capabilities meet the hardest engineering challenges: real-time control, physical uncertainty, and the irreversibility of actions in the world.

**Mental model:** Software AI makes mistakes that can be undone (regenerate, retry, rollback). Embodied AI makes mistakes that sometimes can't be (a robot drops a fragile item, a car takes the wrong turn). This asymmetry shapes everything about how these systems are designed.

---

## Prerequisites
- Transformers, LLM Failures modules (for grounding on current AI capabilities)

---

## Best resources

**Primary:**
1. [Andrej Karpathy – Tesla AI Day talk](https://www.youtube.com/watch?v=j0z4FweCy4M) (2021, still relevant; how a frontier team thinks about embodied AI)
2. [Boston Dynamics blog](https://bostondynamics.com/blog/) — practical robotics engineering perspectives

**Supporting:**
- [Google DeepMind robotics research](https://deepmind.google/research/areas/robotics/) — RT-2, SayCan
- [Waymo safety report](https://waymo.com/safety/) — how autonomous driving handles uncertainty
- [Figure AI](https://www.figure.ai/) — humanoid robotics + AI integration

**YouTube:**
- [The state of robotics – Two Minute Papers](https://www.youtube.com/watch?v=Sq1QZB5baNw) (10 min)
- [RT-2 explained – Google DeepMind](https://www.youtube.com/watch?v=UcCLGCTAhF0) (15 min)
- [Figure 01 – OpenAI + robotics demo](https://www.youtube.com/watch?v=Sq1QZB5baNw) (10 min)

---

## Core concepts (survey level)

### Why embodied AI is hard
- **Sim-to-real gap:** robots trained in simulation often fail in the real world (physics differences, sensor noise)
- **Long-horizon planning:** physical tasks require many sequential steps; errors compound
- **Real-time constraints:** control loops run at 100–1000Hz; LLMs are too slow for direct control
- **Irreversibility:** physical mistakes can't be rolled back
- **Perception uncertainty:** cameras and sensors give noisy, incomplete views of the world
- **Generalization:** a robot that handles one type of object may fail on slight variations

### Current approaches
- **Classic robotics + AI perception:** traditional motion planning + LLM for task understanding
- **End-to-end learned policies:** neural networks map sensors → actions (limited generalization)
- **Foundation models for robotics (RT-2, SayCan):** use vision-language models to interpret tasks; translate to low-level robot actions
- **Sim-to-real transfer:** train in simulation (cheap); transfer to real hardware (hard)

### Key players (2026)
- **Boston Dynamics (Hyundai):** Atlas, Spot — most capable hardware; classical + learned control mix
- **Figure AI, Agility Robotics, 1X:** humanoid robots aimed at warehouse/logistics
- **Tesla Optimus:** humanoid; leverages Tesla's FSD (Full Self-Driving) data pipeline
- **DeepMind robotics:** leading research on foundation models for manipulation
- **Waymo, Cruise, Mobileye:** autonomous driving (specialized embodied AI)

### Autonomous vehicles as a case study
- AV is the most mature form of embodied AI at scale
- Stack: perception (cameras/LiDAR/radar) → prediction (what will other vehicles do?) → planning (what should we do?) → control (execute the maneuver)
- Safety approach: "defensive driving" assumptions; disengage to human when uncertain; shadow driving before commercial deployment
- Waymo's approach: high-definition maps + sensor fusion + conservative policy

### What's actually hard vs what's hype
- **Hard (genuinely unsolved):** general manipulation, outdoor unstructured environments, true zero-shot generalization
- **Working well now:** structured environments (warehouses), specific tasks (pick-and-place), autonomous driving on mapped roads
- **Hype zone:** claims of general-purpose household robots being "solved" — still 5–10+ years away for reliable consumer deployment

---

## Exercises

**Set 1 — Technology landscape map (30 min):**
Research and create a table of 6 robotics companies:
- Company, product, use case, current deployment scale, AI approach (LLM-based, classical, hybrid)
- Note: what specific task are they doing, and how close are they to real commercial deployment?
Save to `docs/reading/robotics-landscape.md`.

**Set 2 — Watch and annotate (30 min):**
Watch the Tesla AI Day or Boston Dynamics Atlas video.
Pause at 3 moments where you see a technical challenge. Write:
- What is the robot doing?
- What could go wrong?
- What engineering solution are they using?
Save to `docs/reading/robotics-video-notes.md`.

**Set 3 — Sim-to-real reading (20 min):**
Search for "sim-to-real gap robotics" — find one paper or blog post explaining the challenge.
Write a 5-bullet summary: what is the gap, why does it occur, and what are 2 approaches to bridging it?
Save to `docs/reading/sim-to-real-notes.md`.

---

## Checks — you understand this when you can:
- [ ] Explain 3 reasons embodied AI is harder than language AI
- [ ] Describe the AV perception → prediction → planning → control stack
- [ ] Name 3 companies in robotics and explain what specific task they're tackling
- [ ] Explain the sim-to-real gap
- [ ] Separate realistic near-term robotics from hype

---

## Artifacts to commit
- [ ] `docs/reading/robotics-landscape.md`
- [ ] `docs/reading/robotics-video-notes.md`
- [ ] `docs/reading/sim-to-real-notes.md`
- [ ] Glossary entries: embodied AI, sim-to-real gap, humanoid robot, AV stack, foundation model for robotics
- [ ] Log entry in `docs/log.md`
