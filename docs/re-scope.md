# Firecrawl RE Scope

date: 2026-06-15
scope: public-source research only

Allowed:
- Public GitHub repositories under `github.com/firecrawl`.
- Public docs, READMEs, Docker files, tests, workflows, SDKs, CLIs, and examples.
- Local self-host setup analysis from source and compose files.
- API behavior checks using the user's valid Firecrawl API key through the installed CLI.

Not allowed:
- Hosted Firecrawl infrastructure discovery beyond published docs and public DNS/HTTP behavior needed for normal client use.
- Credential extraction, session scraping, tenant enumeration, or auth bypass.
- Writing secret values into this repo, docs, logs, prompts, or GitHub Actions.
- Destructive changes to upstream clones.

Completeness definition:
- Clone or inventory every non-archived public repo in the Firecrawl GitHub org.
- Deep RE the core system first: `firecrawl`, `cli`, `firecrawl-docs`, `firecrawl-mcp-server`, and official plugin repos.
- Track non-core app/example repos as ecosystem evidence unless they contain shared libraries or deployment-critical code.

Current boundary:
- The public monorepo does not include private hosted Firecrawl SaaS configuration, production secrets, or managed proxy infrastructure. Those cannot and should not be cloned.
