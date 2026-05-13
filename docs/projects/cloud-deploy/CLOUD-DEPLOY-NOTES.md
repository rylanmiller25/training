# Cloud Deploy Notes

## Platform: Railway

**Live URL:** https://training-production-3433.up.railway.app

---

## Steps taken

1. Created minimal Express.js app in `docs/projects/cloud-deploy/` with `server.js` and `package.json`
2. Used `process.env.PORT` for port binding — Railway injects this at runtime; hardcoding 3000 would cause the deploy to fail
3. Pushed to GitHub
4. Created new Railway project → Deploy from GitHub repo → selected training repo
5. Set Root Directory to `docs/projects/cloud-deploy` in Railway Settings
6. Railway auto-detected Node.js, ran `npm install` and `npm start`
7. Generated public domain under Settings → Networking → Generate Domain

## Key lessons

- Railway does not assign a public URL automatically — you have to generate a domain manually under Networking settings
- Railway requires explicit GitHub repo authorization — if your repo doesn't appear, go to Settings → Integrations → GitHub → Configure to grant access
- `process.env.PORT` is required for Railway deployments; Railway injects the port at runtime
