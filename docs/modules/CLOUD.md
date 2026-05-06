# Module: Cloud Fundamentals

**Phase:** 2  
**Slug:** `cloud`  
**Status:** not started  

---

## What it is / how to think about it

Cloud computing means renting compute, storage, and networking from a provider (AWS, GCP, Azure) instead of owning servers. You pay for what you use, scale on demand, and skip the data center.

**Mental model:** Cloud providers are like utility companies — electricity on demand. You don't own a power plant; you plug in and pay per kilowatt-hour. Similarly, you don't own servers; you provision a VM and pay per hour.

The three layers to understand:
- **IaaS** (Infrastructure as a Service): raw VMs, storage, networking (e.g. EC2, GCS)
- **PaaS** (Platform as a Service): managed runtime — deploy code, provider handles OS/scaling (e.g. Heroku, App Engine, Railway)
- **SaaS** (Software as a Service): finished product (Slack, Notion)

---

## Prerequisites
- CLI/Linux, Git, Docker modules

---

## Best resources

**Primary:**
1. [AWS Cloud Practitioner Essentials](https://aws.amazon.com/training/learn-about/cloud-practitioner/) — free course, 6 hours, covers all core concepts. Best structured intro even if you end up using GCP.
2. [Google Cloud Skills Boost – Cloud Digital Leader path](https://cloudskillsboost.google/paths/9) — free, interactive labs

**Supporting:**
- [AWS in Plain English](https://aws.plainenglish.io/) — humanized service names and analogies
- [The Good Parts of AWS – David Yanowitz](https://gumroad.com/l/aws-good-parts) — short opinionated guide on what to actually use
- [Cloud pricing calculator – AWS](https://calculator.aws/pricing/2/home) — build intuition for costs

**YouTube:**
- [AWS Explained – Fireship](https://www.youtube.com/watch?v=M988_fsOSWo) (10 min — high-level survey)
- [AWS Certified Cloud Practitioner – freeCodeCamp](https://www.youtube.com/watch?v=SOTamWNgDKc) (14 hrs — use as reference; don't watch end-to-end)
- [Serverless explained – Fireship](https://www.youtube.com/watch?v=W_VV2Fx32_Y) (6 min)

---

## Core concepts to cover

### Compute
- **EC2 (VMs):** rent a virtual machine; you manage the OS
- **ECS/EKS:** run containers; ECS = AWS-native, EKS = managed Kubernetes
- **Lambda (serverless):** run a function in response to an event; pay per invocation, not uptime
- **App Runner / Render / Railway:** simplest PaaS — connect a repo, it handles the rest

### Storage
- **S3 (object storage):** store files/blobs at any scale; global CDN; pay per GB stored + requests
- **EBS (block storage):** disk attached to a VM (like a hard drive)
- **RDS:** managed relational database (Postgres/MySQL); automated backups, patching
- **DynamoDB:** managed NoSQL key-value/document store; scales automatically

### Networking
- **VPC (Virtual Private Cloud):** your private network in the cloud
- **Subnets:** public (internet-accessible) vs private (internal only)
- **Security groups:** firewall rules for what traffic reaches your resources
- **Load balancer:** distributes traffic across multiple instances
- **CDN (CloudFront):** caches content at edge locations worldwide

### Serverless
- Functions trigger on: HTTP request, queue message, file upload, schedule
- Cold start: first invocation takes longer (function spins up from zero)
- Stateless by design — no persistent local storage between invocations
- Best for: event-driven, bursty, or low-traffic workloads

### Billing intuition
- Compute: pay per hour (VMs) or per invocation + duration (Lambda)
- Storage: pay per GB/month; S3 also charges per API request
- Data transfer: **egress** (out of cloud) costs money; ingress (in) is usually free
- Reserved instances: commit to 1–3 years for 30–60% discount
- Rule of thumb: the biggest bills come from egress, large EC2 instances, and data transfer between regions

### Regions and availability
- **Region:** geographic area (us-east-1 = N. Virginia)
- **Availability Zone (AZ):** isolated data center within a region; run across 2+ AZs for resilience
- **Multi-region:** for global latency or disaster recovery

---

## Exercises

**Set 1 — Conceptual mapping (20 min):**
Without using Google, map each of these to the closest AWS equivalent:
- "Run a script that fires when a file is uploaded" → ?
- "Store user profile pictures" → ?
- "Managed Postgres database" → ?
- "Deploy a Docker container without managing servers" → ?
Check your answers against AWS docs.

**Set 2 — Cost estimation (30 min):**
Use the [AWS Pricing Calculator](https://calculator.aws/pricing/2/home) to estimate monthly cost for:
1. A t3.micro EC2 instance running 24/7
2. 100 GB of S3 storage with 1M GET requests/month
3. An RDS Postgres db.t3.micro with 20 GB storage
4. A Lambda function called 1M times/month, running 500ms each at 128 MB
Write the estimates in `docs/reading/CLOUD-COST-ESTIMATES.md`.

**Set 3 — Deploy something (45–60 min):**
Deploy a simple web app using a free PaaS tier:
- [Railway](https://railway.app/) or [Render](https://render.com/) (both have free tiers)
1. Create a minimal Express.js app: `GET /` returns `{"status":"ok"}`
2. Push to GitHub
3. Connect the repo to Railway/Render; deploy
4. Hit the live URL — confirm it works
5. Record the URL and deploy steps in `docs/projects/CLOUD-DEPLOY-NOTES.md`

**Set 4 — Serverless function (30 min):**
Deploy a Lambda-equivalent serverless function:
- Use [Vercel](https://vercel.com/) or [Netlify Functions](https://www.netlify.com/products/functions/) (both free)
1. Create a function that returns current UTC timestamp as JSON
2. Deploy; hit the endpoint
3. Check the invocation logs in the dashboard

---

## Checks — you understand this when you can:
- [ ] Explain IaaS vs PaaS vs SaaS with a concrete example of each
- [ ] Name the AWS service you'd use for: hosting a container, storing files, managed Postgres, a triggered function
- [ ] Explain what a VPC, subnet, and security group are
- [ ] Estimate a rough monthly cost for a simple 3-tier app
- [ ] Explain what a serverless cold start is and when it matters
- [ ] Explain why data egress costs money and ingress usually doesn't

---

## Artifacts to commit
- [ ] `docs/reading/CLOUD-COST-ESTIMATES.md` — your pricing exercise
- [ ] `docs/projects/CLOUD-DEPLOY-NOTES.md` — deploy steps + live URL
- [ ] Glossary entries: IaaS, PaaS, SaaS, EC2, S3, Lambda, serverless, VPC, CDN, availability zone
- [ ] Log entry in `docs/LOG.md`
