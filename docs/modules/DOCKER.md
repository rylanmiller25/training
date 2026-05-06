# Module: Docker

**Phase:** 2  
**Slug:** `docker`  
**Status:** not started  

---

## What it is / how to think about it

Docker packages an application and all its dependencies into a portable unit called a **container**. The container runs identically on your laptop, a CI server, and in production — eliminating "it works on my machine."

**Mental model:** A container is like a shipping container for software. The **image** is the blueprint (read-only); the **container** is a running instance of that blueprint. Images are built from a `Dockerfile` — a recipe of steps.

Key insight: containers share the host OS kernel but are isolated from each other. They're much lighter than virtual machines (which carry a full OS).

---

## Prerequisites
- CLI/Linux module (you'll use the terminal for all Docker commands)
- Git/GitHub module (Dockerfiles live in repos)

---

## Best resources

**Primary:**
1. [Docker official "Get Started" tutorial](https://docs.docker.com/get-started/) — hands-on, official, up-to-date (free)
2. [Play with Docker](https://labs.play-with-docker.com/) — browser-based Docker environment, no install needed

**Supporting:**
- [Docker cheat sheet – collabnix](https://dockerlabs.collabnix.com/docker/cheatsheet/)
- [Dockerfile best practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
- [Docker Compose overview](https://docs.docker.com/compose/)

**YouTube:**
- [Docker in 100 Seconds – Fireship](https://www.youtube.com/watch?v=Gjnup-PuquQ) (2 min — mental model)
- [Docker Tutorial for Beginners – TechWorld with Nana](https://www.youtube.com/watch?v=3c-iBn73dDE) (3 hrs — thorough; watch in sections)
- [Docker Compose – TechWorld with Nana](https://www.youtube.com/watch?v=SXwC9fSwct8) (56 min)

---

## Core concepts to cover

### Images vs containers
```bash
docker pull node:18          # download image
docker images                # list local images
docker run node:18 node -e "console.log('hello')"  # run container
docker ps                    # list running containers
docker ps -a                 # including stopped
docker stop <id>
docker rm <id>
docker rmi <image>           # remove image
```

### Running containers interactively
```bash
docker run -it ubuntu bash          # interactive terminal
docker run -d nginx                 # detached (background)
docker run -p 8080:80 nginx         # port mapping: host:container
docker run -v $(pwd):/app node:18   # volume mount
docker exec -it <id> bash           # shell into running container
docker logs <id>                    # view container output
```

### Writing a Dockerfile
```dockerfile
FROM node:18-alpine          # base image (alpine = small)
WORKDIR /app                 # set working directory
COPY package*.json ./        # copy dependency files first (layer caching)
RUN npm install              # install deps
COPY . .                     # copy rest of code
EXPOSE 3000                  # document the port
CMD ["node", "server.js"]    # default command
```

```bash
docker build -t my-app:1.0 .    # build image from Dockerfile
docker build --no-cache -t my-app .  # force fresh build
```

### Docker Compose (multi-container apps)
```yaml
# docker-compose.yml
version: "3"
services:
  web:
    build: .
    ports:
      - "3000:3000"
    depends_on:
      - db
  db:
    image: postgres:15
    environment:
      POSTGRES_PASSWORD: secret
    volumes:
      - db-data:/var/lib/postgresql/data
volumes:
  db-data:
```
```bash
docker compose up -d       # start all services
docker compose down        # stop and remove containers
docker compose logs web    # logs for one service
```

### Key concepts to understand
- **Layer caching:** each Dockerfile instruction is a cached layer — order matters for build speed
- **`.dockerignore`:** like `.gitignore`, prevents copying node_modules etc. into the image
- **Named volumes vs bind mounts:** volumes are managed by Docker (persistent); bind mounts link to host paths (dev)
- **Environment variables:** pass with `-e VAR=value` or `env_file:` in Compose

---

## Exercises

**Set 1 — Pull and run (20 min):**
1. `docker run hello-world` — confirm Docker is working.
2. `docker run -it ubuntu bash` — explore the container. Run `ls`, `pwd`, `cat /etc/os-release`. Exit with `exit`.
3. `docker run -d -p 8080:80 nginx` — run nginx. Visit http://localhost:8080 in browser. Stop the container.

**Set 2 — Build your first image (45 min):**
Create a minimal Node.js app in `docs/projects/docker-hello/`:
1. `server.js` that responds "Hello from Docker!" on port 3000
2. `package.json` with `{"name":"docker-hello","scripts":{"start":"node server.js"}}`
3. `Dockerfile` based on `node:18-alpine`
4. `.dockerignore` excluding `node_modules`
5. Build: `docker build -t docker-hello .`
6. Run: `docker run -p 3000:3000 docker-hello`
7. Visit http://localhost:3000. Confirm it works.

**Set 3 — Docker Compose (45 min):**
Add a `docker-compose.yml` to your project that runs:
- Your Node app on port 3000
- A Redis container (`redis:7-alpine`) for future use
1. `docker compose up` — confirm both start.
2. `docker compose logs` — see output.
3. `docker compose down` — clean up.

**Set 4 — Layer caching experiment (15 min):**
1. Build your image (note the time).
2. Change only `server.js` (not package.json).
3. Build again — observe which layers are cached.
4. Now change `package.json`. Build again — notice npm install re-runs.
Write a 2-sentence note in `docs/LOG.md` explaining what you observed.

---

## Checks — you understand this when you can:
- [ ] Explain the difference between an image and a container
- [ ] Run a container with port mapping and volume mount
- [ ] Write a Dockerfile for a simple Node.js app
- [ ] Explain what layer caching is and why COPY order matters
- [ ] Use Docker Compose to run a multi-container app
- [ ] Explain when you'd use a named volume vs bind mount

---

## Artifacts to commit
- [ ] `docs/projects/docker-hello/` — Dockerfile, server.js, docker-compose.yml
- [ ] Glossary entries: container, image, Dockerfile, layer caching, volume, Docker Compose
- [ ] Log entry in `docs/LOG.md`
