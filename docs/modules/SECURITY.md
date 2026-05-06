# Module: Security Basics

**Phase:** 2  
**Slug:** `security`  
**Status:** not started  

---

## What it is / how to think about it

Security is about protecting systems from unintended access, data leakage, and manipulation. For a technical PM, the goal isn't to become a security engineer — it's to recognize risk in designs, ask the right questions, and know what "secure by default" means.

**Mental model:** Think of security in layers. Defense in depth means you don't rely on any single control. Attackers look for the weakest link — often not the cryptography, but a forgotten API endpoint or an unsanitized input field.

---

## Prerequisites
- HTTP + APIs, SQL, Cloud modules

---

## Best resources

**Primary:**
1. [OWASP Top 10](https://owasp.org/www-project-top-ten/) — the canonical list of web application vulnerabilities. Read the descriptions for all 10.
2. [Auth0 Identity Fundamentals](https://auth0.com/docs/get-started/identity-fundamentals) — clear, practical guide to authn/authz

**Supporting:**
- [Have I Been Pwned – About](https://haveibeenpwned.com/About) — understand the scale of credential breaches
- [JWT.io](https://jwt.io/) — decode and understand JWT tokens interactively
- [OWASP Cheat Sheet Series](https://cheatsheetseries.owasp.org/) — deep dives per vulnerability type

**YouTube:**
- [Web Security – Fireship](https://www.youtube.com/watch?v=F-sFp_AvHc8) (12 min — OWASP overview, visual)
- [OAuth 2.0 explained – Okta](https://www.youtube.com/watch?v=996OiexHze0) (14 min — clearest OAuth explanation)
- [JWT explained – Web Dev Simplified](https://www.youtube.com/watch?v=7Q17ubqLfaM) (13 min)

---

## Core concepts to cover

### Authentication vs Authorization
- **Authentication (authn):** who are you? Verified via password, token, biometric, MFA
- **Authorization (authz):** what are you allowed to do? Checked after identity is established
- **Common mistake:** checking only that a user is logged in, not that they own the resource they're accessing

### Auth patterns
- **Session-based auth:** server creates a session; stores session ID in a cookie; looks up on each request (stateful)
- **JWT (token-based):** server issues a signed token; client sends it on each request; server verifies signature (stateless)
- **OAuth 2.0:** delegated authorization — "login with Google/GitHub" without sharing your password
  - Authorization Code Flow (for web apps)
  - Client Credentials Flow (for machine-to-machine)
- **API keys:** static secret sent in headers; simpler but harder to rotate; no identity
- **MFA:** second factor (TOTP app, SMS, hardware key) dramatically reduces account takeover risk

### OWASP Top 10 (know what each is)
1. **Broken Access Control** — user accesses resources they shouldn't (e.g. `/api/orders/456` belongs to another user)
2. **Cryptographic Failures** — sensitive data transmitted or stored without encryption
3. **Injection (SQL, command)** — untrusted input executed as code or query
4. **Insecure Design** — architecture lacks security controls from the start
5. **Security Misconfiguration** — default passwords, open S3 buckets, verbose error messages
6. **Vulnerable Components** — outdated deps with known CVEs
7. **Identification/Authentication Failures** — weak passwords, no MFA, broken session management
8. **Software/Data Integrity Failures** — unverified updates, insecure deserialization
9. **Security Logging Failures** — no audit trail for sensitive operations
10. **SSRF (Server-Side Request Forgery)** — server makes requests to internal services based on user input

### SQL Injection
```sql
-- Vulnerable: string concatenation
query = "SELECT * FROM users WHERE email = '" + userInput + "'"
-- Input: ' OR '1'='1  → returns all users

-- Safe: parameterized queries / prepared statements
query = "SELECT * FROM users WHERE email = $1", [userInput]
```

### XSS (Cross-Site Scripting)
- Attacker injects JavaScript that runs in other users' browsers
- **Stored XSS:** malicious script saved to DB, served to all viewers
- **Reflected XSS:** script in URL parameter, reflected back in response
- **Prevention:** output encoding, Content Security Policy (CSP), never use `innerHTML` with user input

### Secrets management
- Never hardcode secrets in source code (caught by `git log` forever)
- Use environment variables; use a secrets manager (AWS Secrets Manager, Vault)
- Rotate keys regularly; use different keys per environment
- `.env` files: in `.gitignore`; never committed

### HTTPS + certificates
- All traffic must be encrypted in transit (TLS/SSL)
- HTTPS = HTTP + TLS; certificate issued by a Certificate Authority
- Let's Encrypt = free, automated TLS certificates
- HSTS: tell browsers to always use HTTPS (prevent downgrade attacks)

### Secure-by-default principles
- Principle of least privilege: grant minimum permissions needed
- Allowlist > blocklist: define what's allowed, reject everything else
- Fail securely: on error, deny access (don't default to permissive)
- Defense in depth: multiple layers; no single point of failure

---

## Exercises

**Set 1 — Recognize vulnerabilities (30 min):**
Read the OWASP Top 10 descriptions. For each, write one real-world scenario where it could occur. Save to `docs/reading/OWASP-SCENARIOS.md`.

**Set 2 — Decode a JWT (20 min):**
1. Go to jwt.io
2. Paste this token and decode it: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c`
3. Identify: header, payload, signature. What algorithm is used? What claims are in the payload?
4. Answer: can you modify the payload without the server knowing? Why or why not?
Write your answers in `docs/reading/JWT-EXERCISE.md`.

**Set 3 — Find a security misconfiguration (20 min):**
Search for "exposed .env files site:github.com" (or use a safe demo). Notice how common it is. Then:
1. Check this training repo: does `.gitignore` exclude `.env`? Add it if not.
2. Run `git log --all --oneline` — confirm no `.env` has ever been committed.
3. Write a 3-bullet checklist for "before I push any new repo" security checks.

**Set 4 — Auth flow diagram (30 min):**
Draw the OAuth 2.0 Authorization Code flow:
- User, Browser, Your App, Google OAuth Server, Your Backend
- Label each arrow with what's being sent (authorization code, access token, etc.)
Save as `docs/reading/OAUTH-FLOW-DIAGRAM.md` (text description or ASCII diagram is fine).

---

## Checks — you understand this when you can:
- [ ] Explain the difference between authentication and authorization
- [ ] Explain what a JWT is, what it contains, and why you can't fake one
- [ ] Explain SQL injection and how parameterized queries prevent it
- [ ] Explain XSS and one prevention technique
- [ ] Name 5 of the OWASP Top 10 and describe the vulnerability
- [ ] Explain the OAuth 2.0 Authorization Code flow step by step
- [ ] Explain the principle of least privilege

---

## Artifacts to commit
- [ ] `docs/reading/OWASP-SCENARIOS.md`
- [ ] `docs/reading/JWT-EXERCISE.md`
- [ ] `docs/reading/OAUTH-FLOW-DIAGRAM.md`
- [ ] Glossary entries: authn, authz, JWT, OAuth, SQL injection, XSS, HTTPS, SSRF, least privilege
- [ ] Log entry in `docs/LOG.md`
