# Panel — Deployment Architecture

**Status:** Draft  
**Last updated:** 2026-05-13

---

## Services overview

Panel has four runtime services and two managed infrastructure dependencies:

| Service | What it does | Runtime |
|---|---|---|
| API server | Handles all HTTP requests: assignment, event ingestion, results, simulation | Node.js / TypeScript |
| Causal forest worker | Picks up jobs from queue, runs EconML, writes results to database | Python |
| PostgreSQL | Primary database: experiments, assignments, events, results | Managed (RDS) |
| Redis | Job queue backend for BullMQ; causal forest jobs enqueued here | Managed (ElastiCache) |
| S3 | Raw data exports (Pro/Enterprise), model artifacts | Object storage |

---

## MVP deployment (pre-enterprise)

The causal forest worker does not run in the MVP. Causal forests are an enterprise-only feature and there is no reason to provision the worker until the first enterprise customer is paying for it. The MVP ships HTE via interaction terms, which runs in the API server as part of result computation — no separate worker needed.

```
Internet
    │
    ▼
Railway (API server)
    │              │
    ▼              ▼
RDS Postgres   ElastiCache Redis
                   (queue, no workers consuming yet)
    │
    ▼
S3 (exports)
```

**Services at MVP:**

| Service | Where it runs | Rationale |
|---|---|---|
| API server | Railway (PaaS) | Zero infrastructure management; free tier covers early traffic; deploys from GitHub automatically |
| PostgreSQL | AWS RDS `db.t3.micro` | Managed backups, patching; Single-AZ until paying customers justify Multi-AZ |
| Redis | AWS ElastiCache `cache.t3.micro` | BullMQ requires Redis; managed is simpler than self-hosting on EC2 |
| S3 | AWS S3 | Raw data export for Pro users; negligible cost at early stage |

**Estimated MVP cost: ~$35–50/month**
- RDS: ~$15/mo
- ElastiCache: ~$15/mo
- S3: ~$5/mo
- Railway: free tier to start; ~$5–20/mo once traffic warrants

---

## Production deployment (post-enterprise)

Once enterprise customers exist, the causal forest worker is provisioned. The API server moves off Railway onto a container runtime for more control over scaling and networking.

```
Internet
    │
    ▼
Load Balancer (ALB)
    │
    ▼
ECS (API server containers)
    │              │              │
    ▼              ▼              ▼
RDS Postgres   ElastiCache    S3
               Redis
                   │
                   ▼ (job queue)
             EC2 c6a.2xlarge
             (causal forest worker)
```

**Services at production:**

| Service | Where it runs | Notes |
|---|---|---|
| API server | AWS ECS (containerized) | Auto-scales horizontally behind ALB; same Docker image as local dev |
| Causal forest worker | AWS EC2 `c6a.2xlarge` | Compute-optimized (16 vCPUs); EconML parallelizes across all cores via `n_jobs=-1` |
| PostgreSQL | AWS RDS `db.t3.small` | Upgrade from micro; add Multi-AZ when uptime SLA is required |
| Redis | AWS ElastiCache `cache.t3.micro` | No change from MVP |
| S3 | AWS S3 | No change from MVP |

**Estimated production cost (excluding causal forest worker): ~$35–50/month**
Same as MVP — the only addition is moving the API server to ECS, which costs similarly to Railway at low traffic.

**Estimated production cost (including causal forest worker): ~$220–230/month**
The EC2 `c6a.2xlarge` adds ~$185/month and dominates the bill. This cost is only incurred once enterprise customers with sufficient experiment data are actively using causal forest analysis. See `docs/reading/CLOUD-COST-ESTIMATES.md` for full breakdown.

> **Note:** The causal forest worker should be provisioned incrementally as enterprise customers onboard. At low enterprise volume, running the worker on-demand (spin up when jobs are queued, terminate when idle) can significantly reduce cost below the always-on $185/month estimate. Switch to a reserved instance once usage is predictable enough to justify a 1-year commit (~35% discount).

---

## Scaling strategy

**API server** scales horizontally — add ECS tasks behind the load balancer as request volume grows. Stateless by design (all state lives in Postgres and Redis), so horizontal scaling is straightforward.

**Causal forest worker** scales vertically first — a larger EC2 instance (more cores) handles more concurrent jobs faster. At high enterprise volume, run multiple workers behind the same BullMQ queue.

**PostgreSQL** is the hardest to scale. Vertical scaling (larger instance) handles most growth. Read replicas can offload result queries if they become a bottleneck. Sharding is not anticipated at this stage.

**Cost optimization levers:**
- Switch EC2 to 1-year reserved instance once usage is predictable → ~35% discount (~$65/mo savings)
- Run causal forest worker on-demand only (provision when jobs are queued, terminate when idle) → significant savings at low job volume
- Add RDS Multi-AZ only when an uptime SLA is contractually required — roughly doubles RDS cost

---

## Regions and availability

**MVP:** Single region, US East (N. Virginia / `us-east-1`). Cheapest AWS region; lowest latency for likely early customer base.

**Single-AZ for all services at MVP.** Multi-AZ for RDS adds ~$15/mo and is not justified until there are enterprise customers with uptime requirements.

**Future:** Multi-AZ RDS and ECS tasks spread across two AZs when the first enterprise SLA requires it. Multi-region is not anticipated unless international customers with data residency requirements emerge.

---

## Local development

All services run locally via Docker Compose. See `src/docker-compose.yml` (to be produced during capstone) for the full configuration. Local setup mirrors production: API server, Python worker, Postgres, and Redis all run as separate containers.

---

## Open questions

- **Worker provisioning:** on-demand spin-up (terminate when idle) vs. always-on reserved instance — depends on experiment volume per enterprise customer. Revisit at first enterprise contract.
- **Data warehouse integration:** enterprise customers may want Panel data exported directly to Snowflake/BigQuery. Architecture for this (direct export vs. S3 intermediate) is not designed yet.
- **HIPAA eligibility:** if healthcare customers emerge, VPC isolation and encryption requirements will materially change the networking design.
