prisma/prisma/.github/workflows/daily-test.yml

- Pipelines are triggered every weekday morning at 4AM.
- The test-template.yml file is run.
- There are no matrix builds.
- Nothing gets deployed.
- Without CI, a breaking change could sit undetected in main for days until someone happened to trigger a build.
