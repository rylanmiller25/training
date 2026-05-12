# Module: HTTP + REST APIs

**Phase:** 1  
**Slug:** `http-apis`  
**Status:** Completed 

---

## What it is / how to think about it

HTTP is the language of the web. Every time your browser loads a page, or an app calls a backend, it's sending HTTP requests and receiving responses. REST is a set of conventions on top of HTTP for building APIs.

**Mental model:** Think of HTTP as letters. A request is a letter you send (with a method, URL, headers, and optional body). A response is the reply (with a status code, headers, and optional body). REST says: use the right "verb" (GET/POST/PUT/DELETE) for the right action, and structure your URLs around resources.

---

## Prerequisites
- CLI/Linux module (curl is a command-line tool)
- Helpful but not required: some programming background

---

## Best resources

**Primary:**
1. [MDN HTTP overview](https://developer.mozilla.org/en-US/docs/Web/HTTP/Overview) — authoritative, free, well-structured
2. [RESTful API Design – Best Practices](https://restfulapi.net/) — canonical patterns reference

**Supporting:**
- [HTTP Status Codes](https://httpstatuses.io/) — quick reference; bookmark this
- [JSON overview – MDN](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Objects/JSON)
- [curl manual](https://curl.se/docs/manpage.html) — or `man curl`

**YouTube:**
- [HTTP Crash Course – Traversy Media](https://www.youtube.com/watch?v=iYM2zFP3Zn0) (38 min — broad intro)
- [REST API concepts – WebConcepts](https://www.youtube.com/watch?v=7YcW25PHnAA) (8 min — clean summary)
- [What is an API? – Fireship](https://www.youtube.com/watch?v=ByGJQzlzxQg) (10 min)

---

## Core concepts to cover

### HTTP basics
- **Methods:** GET (read), POST (create), PUT/PATCH (update), DELETE (remove)
- **Status codes:**
  - 2xx: success (200 OK, 201 Created, 204 No Content)
  - 3xx: redirect (301 permanent, 302 temporary)
  - 4xx: client error (400 Bad Request, 401 Unauthorized, 403 Forbidden, 404 Not Found, 422 Unprocessable, 429 Rate Limit)
  - 5xx: server error (500 Internal, 502 Bad Gateway, 503 Unavailable)
- **Headers:** Content-Type, Authorization, Accept, Cache-Control
- **Request body:** JSON (most common), form data, multipart
- **URL anatomy:** scheme, host, path, query params, fragment

### REST conventions
- Resources as nouns in URLs: `/users/123`, `/orders/456/items`
- HTTP methods map to CRUD operations
- Stateless: each request contains everything needed (no server-side session)
- Consistent response shapes

### Authentication patterns
- **API key** — token in header (`Authorization: Bearer <key>`) or query param
- **Basic auth** — base64(username:password) in header (avoid for production)
- **OAuth 2.0** — delegated access via access tokens (Google login, GitHub OAuth)
- **JWT (JSON Web Token)** — self-contained signed token; server verifies signature without DB lookup

### Practical: curl
```bash
# GET request
curl https://api.github.com/users/octocat

# GET with header
curl -H "Authorization: Bearer TOKEN" https://api.example.com/me

# POST with JSON body
curl -X POST https://api.example.com/items \
  -H "Content-Type: application/json" \
  -d '{"name": "widget", "price": 9.99}'

# See response headers
curl -I https://api.example.com

# Verbose (see full request + response)
curl -v https://api.example.com
```

### Practical: Postman
- Creating a collection and environment
- Saving requests with variables (e.g. `{{base_url}}`)
- Setting Authorization headers
- Reading and asserting on response bodies

---

## Exercises

**Set 1 — Read requests with curl (20 min):**
1. `curl https://api.github.com/users/<your-github-username>` — examine the JSON.
2. Pipe through jq: `curl https://api.github.com/users/octocat | jq '.name, .public_repos'`
3. Check status code: `curl -o /dev/null -s -w "%{http_code}" https://api.github.com/users/octocat`
4. Try a 404: `curl -o /dev/null -s -w "%{http_code}" https://api.github.com/users/thisuserdoesnotexist99999`

**Set 2 — Public API exploration (30 min):**
Use a public API (no auth needed):
- [JSONPlaceholder](https://jsonplaceholder.typicode.com/) — fake REST API for practice
1. `curl https://jsonplaceholder.typicode.com/posts/1` — read post #1
2. `curl https://jsonplaceholder.typicode.com/posts?userId=1` — filter by userId
3. POST a new post (it won't actually save, but returns a 201):
```bash
curl -X POST https://jsonplaceholder.typicode.com/posts \
  -H "Content-Type: application/json" \
  -d '{"title": "test", "body": "hello", "userId": 1}'
```

**Set 3 — Postman collection (45 min):**
1. Install Postman (postman.com)
2. Create a collection called "Phase 1 Practice"
3. Create an environment with variable `base_url = https://jsonplaceholder.typicode.com`
4. Add requests: GET /posts, GET /posts/1, POST /posts
5. Use `{{base_url}}` in all request URLs
6. Export the collection to `docs/projects/phase1-postman.json`

**Set 4 — Status code quiz (10 min):**
Without looking, name a scenario that would produce:
- 400, 401, 403, 404, 429, 500, 503
Write your answers in a note; check against httpstatuses.io.

---

## Checks — you understand this when you can:
- [X] Explain what HTTP is and the request/response cycle
- [X] Name the 5 main HTTP methods and when to use each
- [X] Decode any status code by its class (2xx/3xx/4xx/5xx)
- [X] Make GET and POST requests with curl, including headers and JSON body
- [X] Explain the difference between authentication and authorization
- [X] Explain what a JWT is and why it doesn't need DB lookup
- [X] Build a basic Postman collection with environments and variables

---

## Artifacts to commit
- [X] `docs/projects/phase1-postman.json` — exported Postman collection
- [X] Glossary entries: HTTP, REST, API, status code, header, JSON, JWT, OAuth, idempotent
- [X] Log entry in `docs/LOG.md`
