# skills

A Claude Code plugin (`matthaeusheer-skills`) that is also its own marketplace (`matthaeusheer`).

- One folder per skill under `skills/<name>/`, with a `SKILL.md`. Skills are discovered from `skills/` automatically.
- Write and edit skills with the `writing-for-agents` skill.
- Bump `version` in `.claude-plugin/plugin.json` with every change, or installed copies won't update.
- Run `claude plugin validate .` before opening a PR.
