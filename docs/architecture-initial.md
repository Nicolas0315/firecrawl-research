# Firecrawl Initial Architecture RE

date: 2026-06-15
source: `~\work\vendor\firecrawl`

High-level shape:
- Main repo is a monorepo.
- `apps/api` contains the API server and worker code.
- `apps/playwright-service-ts` provides browser scraping support.
- `apps/*-sdk` packages client SDKs for several languages.
- `apps/redis`, `apps/nuq-postgres`, and FoundationDB compose entries support queue/state backends.
- `firecrawl-cli`, `firecrawl-cli-skills`, `firecrawl-skills`, and `firecrawl-workflows` are vendored workflow and agent surfaces.

Runtime components from `docker-compose.yaml`:
- `api`: Node/TypeScript service, starts `dist/src/harness.js --start-docker`.
- `playwright-service`: browser microservice, default scrape endpoint exposed internally as `http://playwright-service:3000/scrape`.
- `redis`: cache/rate-limit/shared state.
- `rabbitmq`: queue transport for API/worker coordination.
- `nuq-postgres`: Postgres-backed queue/storage component.
- `foundationdb` and `foundationdb-init`: experimental queue backend when `NUQ_BACKEND=fdb`.

API and worker signals from `apps/api/package.json`:
- Server entrypoints include `src/index.ts` and `src/harness.ts`.
- Worker commands include queue worker, scrape worker family, extract worker, indexing worker, ZDR worker, NUQ workers, prefetch worker, reconciler worker, and FoundationDB worker.
- Test convention from upstream `AGENTS.md`: prefer E2E/snips tests and use `pnpm harness jest ...` rather than starting services manually.

Core features visible in source/tests:
- V2 endpoints for search, scrape, map, crawl, batch scrape, parse, monitor, billing, cache, webhook, PII, browser, and document conversion tests.
- Search implementation under `apps/api/src/search`.
- Crawling and sitemap logic under `apps/api/src/scraper/WebScraper`.
- Request routing under `apps/api/src/routes`.
- Auth and readiness/liveness controllers under `apps/api/src/controllers`.

External dependencies of note:
- Express, BullMQ, RabbitMQ, Redis, Postgres, FoundationDB, Playwright service, Sentry, Stripe, Autumn billing, Supabase auth/config paths, OpenAI-compatible model providers, SearXNG search, and document parsers.

Open questions:
- Exact hosted production topology differs from public compose and is not publicly cloneable.
- Proxy provider, production queue backend, rate-limit policy, and billing entitlements need source-level mapping without touching hosted internals.
- Need route-level map from `routes/v2.ts` to controllers/services.
