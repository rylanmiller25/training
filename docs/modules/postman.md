# Module: Postman

**Phase:** 1 (Weeks 2–6) — integrated with http-apis  
**Slug:** `postman`  
**Status:** not started  
**Estimated time:** 3–4 hours

---

## What it is / how to think about it

Postman is a GUI tool for making HTTP requests, testing APIs, and building reusable collections. It's how engineers explore unfamiliar APIs, debug integration issues, and share API workflows with teammates.

**Mental model:** Postman is like curl with a UI + memory. You save requests, organize them into collections, and use environments to switch between dev/staging/prod without editing URLs by hand.

---

## Prerequisites
- HTTP + REST APIs module

---

## Best resources

**Primary:**
1. [Postman Learning Center](https://learning.postman.com/docs/getting-started/introduction/) — official docs, always current

**Supporting:**
- [Postman Quick Reference Guide](https://postman-quick-reference-guide.readthedocs.io/en/latest/) — community cheat sheet
- [Public Postman collections](https://www.postman.com/explore) — browse real-world API collections for reference

**YouTube:**
- [Postman Beginner's Course – freeCodeCamp](https://www.youtube.com/watch?v=VywxIQ2ZXw4) (2 hrs — thorough intro)
- [Postman in 30 min – Traversy Media](https://www.youtube.com/watch?v=FjgYtQK_zLE) (if you want a faster intro first)

---

## Core concepts to cover

### Collections + requests
- Creating a collection; adding folders for organization
- Saving requests with descriptive names
- Request types: GET, POST, PUT, PATCH, DELETE
- Setting headers (Content-Type, Authorization)
- Request body: none, raw JSON, form-data, x-www-form-urlencoded

### Environments + variables
- Creating an environment (dev, staging, prod)
- Defining variables: `base_url`, `api_key`, `user_id`
- Using variables in requests: `{{base_url}}/users/{{user_id}}`
- Switching environments without editing requests

### Tests + assertions (basic)
```javascript
// In Postman "Tests" tab (JavaScript)
pm.test("Status is 200", () => pm.response.to.have.status(200));
pm.test("Has id field", () => {
    const body = pm.response.json();
    pm.expect(body.id).to.be.a("number");
});
```

### Pre-request scripts (basic)
```javascript
// Set a dynamic variable before the request runs
pm.environment.set("timestamp", new Date().toISOString());
```

---

## Exercises

**Set 1 — First collection (30 min):**
1. Install Postman (postman.com/downloads)
2. Create collection: "Phase 1 Practice"
3. Create environment: "JSONPlaceholder" with variable `base_url = https://jsonplaceholder.typicode.com`
4. Add requests:
   - GET `{{base_url}}/posts` — name it "List posts"
   - GET `{{base_url}}/posts/1` — name it "Get post"
   - POST `{{base_url}}/posts` with JSON body `{"title": "test", "userId": 1}`
5. Run all three. Verify status codes.

**Set 2 — Auth header (20 min):**
1. Add a request to call the GitHub API: `GET https://api.github.com/user`
2. Set header: `Authorization: Bearer <your_github_token>` (create a token at GitHub → Settings → Developer settings → Personal access tokens)
3. Run it. You should see your GitHub profile.
4. Move the token to an environment variable `github_token` and use `{{github_token}}` in the header.

**Set 3 — Tests (20 min):**
1. In your "Get post" request, add a test:
   - Assert status is 200
   - Assert response body has `id` equal to 1
   - Assert response time is under 500ms: `pm.expect(pm.response.responseTime).to.be.below(500)`
2. Run the request. Confirm tests pass.

**Set 4 — Export (5 min):**
Export the collection as JSON to `docs/projects/phase1-postman.json`. Commit it.

---

## Checks — you understand this when you can:
- [ ] Create a Postman collection with multiple requests using environment variables
- [ ] Set and use Authorization headers for API key and Bearer token auth
- [ ] Write a basic test assertion for status code and response body
- [ ] Switch environments (dev vs prod) without editing request URLs
- [ ] Export and import a collection

---

## Artifacts to commit
- [ ] `docs/projects/phase1-postman.json` — exported collection
- [ ] Log entry in `docs/log.md`
