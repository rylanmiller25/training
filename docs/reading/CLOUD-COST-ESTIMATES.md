# Cloud Cost Estimates — Panel MVP

**Tool used:** AWS Pricing Calculator  
**Region:** US East (N. Virginia)  
**Date:** 2026-05-12

---

## Services estimated

| Service | Configuration | Monthly cost |
|---|---|---|
| EC2 `c6a.2xlarge` | Causal forest worker, Linux, On-Demand, 730 hrs/mo | ~$185 |
| RDS PostgreSQL `db.t3.micro` | Single-AZ, 20 GB gp2 storage | ~$15 |
| ElastiCache Redis `cache.t3.micro` | 1 node, 730 hrs/mo | ~$15 |
| S3 | 50 GB storage, 10K PUTs, 100K GETs, 5 GB egress | ~$5 |
| **Total** | | **~$220–230/mo** |

---

## Key observations

**EC2 dominates the bill.** The compute-optimized instance for the causal forest worker accounts for the majority of infrastructure cost. Everything else (database, Redis, S3) is relatively cheap at early stage.

**EC2 can be deferred.** Causal forests are an enterprise-only feature. There is no reason to provision the worker until the first enterprise customer is paying for it. Pre-enterprise, Panel's real infrastructure is just RDS + Redis + the API server, which can run on a cheap PaaS tier (Railway, Render) or a small general-purpose EC2 instance. Realistic pre-enterprise cost: **$30–50/month**.

**Cost levers when scaling:**
- Switch EC2 to a 1-year reserved instance → ~35% discount (~$65/mo savings)
- Run the worker on-demand only (spin up when jobs are queued, terminate when idle) rather than 24/7 → significant savings at low experiment volume
- Add Multi-AZ to RDS when uptime SLAs matter (roughly doubles RDS cost)
