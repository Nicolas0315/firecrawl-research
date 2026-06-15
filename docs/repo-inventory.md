# Firecrawl Repo Inventory

retrieved: 2026-06-15
command: `gh repo list firecrawl --limit 100 --json name,url,description,isArchived,updatedAt,primaryLanguage`

Core repositories identified:
- `firecrawl/firecrawl`: main TypeScript monorepo for API, workers, SDKs, Playwright service, Redis/Postgres queue support, examples, and deploy/test workflows.
- `firecrawl/cli`: TypeScript CLI and agent skills package; installed locally as Firecrawl CLI `1.19.6`.
- `firecrawl/firecrawl-docs`: public documentation source.
- `firecrawl/firecrawl-mcp-server`: official MCP server for Firecrawl integrations.
- `firecrawl/firecrawl-codex-plugin`: Codex skills plugin installed locally as `firecrawl@firecrawl-dev`.
- `firecrawl/firecrawl-claude-plugin`, `firecrawl/firecrawl-cursor-plugin`, `firecrawl/firecrawl-grok-plugin`: adjacent agent plugin packages.
- `firecrawl/firecrawl-workflows`: workflow assets also vendored in the main repo.
- `firecrawl/pdf-inspector`, `firecrawl/html-extractor`, `firecrawl/html-to-markdown`: extraction/parser libraries relevant to document and HTML processing.
- `firecrawl/firecrawl-py`, `firecrawl/firecrawl-go`, `firecrawl/firecrawl-java-sdk`, `firecrawl/firecrawl-php`, plus SDKs inside the monorepo.

Initial local clones:
- `~\work\vendor\firecrawl`: commit checked with `git rev-parse HEAD` after clone.
- `~\work\vendor\firecrawl-cli`: shallow clone from `https://github.com/firecrawl/cli`.
- `~\work\vendor\firecrawl-codex-plugin`: commit `419c37b0088dc7c31829e9fd09b563c72b8f5bf4`.

Next inventory step:
- Run `scripts/sync-firecrawl-org.ps1 -CoreOnly` to mirror the core set under `mirrors/github-firecrawl`.
- Run without `-CoreOnly` when full public-org local mirroring is required.
