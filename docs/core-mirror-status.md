# Core Mirror Status

date: 2026-06-15
command: `pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/sync-firecrawl-org.ps1 -CoreOnly`
mirror root: `~\work\firecrawl-research\mirrors\github-firecrawl`

Result:
- `cli`: `48a341a`
- `firecrawl`: `d9a35c0`
- `firecrawl-claude-plugin`: `b334475`
- `firecrawl-codex-plugin`: `419c37b`
- `firecrawl-cursor-plugin`: `258da98`
- `firecrawl-docs`: `419b50b`
- `firecrawl-go`: `101dd31`
- `firecrawl-grok-plugin`: `af6c6c0`
- `firecrawl-java-sdk`: `1683226`
- `firecrawl-mcp-server`: `8b62904`
- `firecrawl-php`: `992a68f`
- `firecrawl-py`: `e8c3201`
- `firecrawl-workflows`: `2642a7c`
- `html-extractor`: `0a2b743`
- `html-to-markdown`: `1af9901`
- `n8n-nodes-firecrawl`: `4e10945`
- `open-scouts`: `0d9b714`
- `pdf-inspector`: `9360c84`
- `web-agent`: `f023adf`

Notes:
- These are shallow local mirrors for research. They are intentionally ignored by git.
- Use `scripts/sync-firecrawl-org.ps1` without `-CoreOnly` to mirror every non-archived public repo in the Firecrawl GitHub org.
- Run clone/fetch through the script so `agent-clone-gate.py` is applied before network git operations.
