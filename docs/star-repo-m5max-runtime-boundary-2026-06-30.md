# Star Repo M5Max Runtime Boundary

Date: 2026-06-30

## Scope

This note records how Firecrawl-related starred repository findings should be applied to the M5Max scraping receiver work.

The local mirror is public-source evidence only. Do not start Firecrawl services, call Firecrawl SaaS, use API keys, refresh mirrors, or copy runtime code into receiver repositories from this research pass.

## Evidence Read

- Local mirror: `mirrors/github-firecrawl/firecrawl`
- Commit: `d9a35c0`
- Source paths inspected:
  - `docker-compose.yaml`
  - `apps/api/package.json`
  - tree paths under `apps/api/src/search`, `apps/api/src/scraper`, `apps/api/src/routes`, and `apps/playwright-service-ts`

Observed runtime shape:

- `api` service plus worker families for queue, scrape, extract, indexing, ZDR, NUQ, prefetch, reconciler, and FoundationDB worker paths.
- `playwright-service` browser microservice with a scrape endpoint.
- Redis, RabbitMQ, Postgres/NUQ, and optional FoundationDB queue/state components.
- Search, scrape, map, crawl, batch scrape, parse, monitor, browser, and document conversion APIs.
- SDKs and tests for crawl/scrape/search/parse across several languages.

## Application Decision

Use Firecrawl findings as reference vocabulary only:

- Search/read/enrich pipeline vocabulary can inform `katala-web-research`.
- PDF/text-vs-scanned and document parser vocabulary can inform later public-document fixtures.
- Crawler/service/runtime architecture can inform rejection gates and cost/risk notes.
- SDK request-shape tests can inform saved request envelope fixtures after a receiver has a local need.

Do not use Firecrawl as a first-wave M5Max runtime adapter:

- no Firecrawl CLI/plugin/MCP/API/SaaS call
- no Docker Compose or service startup
- no Playwright service launch
- no Redis/RabbitMQ/Postgres/FoundationDB queue setup
- no API key, token, cookie, hosted account, or production endpoint probing
- no dependency adoption into `tiktok-live-comment`, `SNS-search`, `katala-web-research`, `kalodata-scraper-pr1`, or Seller Center receivers without a fixture failure and explicit approval

## Verification

Passed:

- `pwsh -NoProfile -ExecutionPolicy Bypass -File scripts\validate-research.ps1`
  - Output: `research validation ok`
- `git diff --check`

Not run:

- `scripts\sync-firecrawl-org.ps1`
- Firecrawl CLI/plugin/MCP/API commands
- Docker Compose, Playwright service, workers, SDK E2E, or any networked crawl/scrape command

## Next

Keep Firecrawl in the docs/fixture vocabulary lane. Promote only tiny, synthetic fixture contracts to receiver repos after a specific local fixture gap is identified.
