# skills

A Claude Code plugin (`matthaeusheer-skills`) that is also its own marketplace (`matthaeusheer`). One skill per folder: `skills/<name>/SKILL.md`.

- Use conventional commits (`feat:`, `fix:`, `docs:`, `chore:` …), also for PR titles.
- Bump `version` in `.claude-plugin/plugin.json` with every change, or installed copies won't update.
- Write skills with the `writing-for-agents` skill; run `claude plugin validate .` before a PR.
