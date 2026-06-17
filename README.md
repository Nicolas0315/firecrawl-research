# Firecrawl Research

Public-source research workspace for Firecrawl.

This repo is for:
- cloning public Firecrawl repositories into `mirrors/`
- reverse-engineering architecture from source, docs, tests, and Docker config
- keeping reproducible evidence and GitHub Actions checks

This repo is not for:
- bypassing Firecrawl auth, rate limits, or hosted-service controls
- storing API keys, tokens, cookies, or local CLI credential files
- copying private SaaS state or probing production systems

Optional local vendor mirrors (outside this repo):
- `~/work/vendor/firecrawl`
- `~/work/vendor/firecrawl-cli`
- `~/work/vendor/firecrawl-codex-plugin`

Canonical mirror target inside this repo: `mirrors/github-firecrawl/`

Quick commands:

```powershell
pwsh -NoProfile -ExecutionPolicy Bypass -File scripts\validate-research.ps1
pwsh -NoProfile -ExecutionPolicy Bypass -File scripts\sync-firecrawl-org.ps1 -CoreOnly
```

Initial RE notes:
- [docs/re-scope.md](docs/re-scope.md)
- [docs/architecture-initial.md](docs/architecture-initial.md)
- [docs/repo-inventory.md](docs/repo-inventory.md)
- [docs/core-mirror-status.md](docs/core-mirror-status.md)
- [docs/full-mirror-status.md](docs/full-mirror-status.md)
