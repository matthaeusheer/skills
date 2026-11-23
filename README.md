# skills

My agent skills, packaged as the `matthaeusheer-skills` Claude Code plugin.

## Install

```sh
claude plugin marketplace add matthaeusheer/skills
claude plugin install matthaeusheer-skills@matthaeusheer
```

This also installs its dependency, [`mattpocock-skills`](https://github.com/mattpocock/skills).

Update with `claude plugin marketplace update matthaeusheer && claude plugin update matthaeusheer-skills@matthaeusheer`, or turn on auto-update for the marketplace in `/plugin`.

## Skills

| Skill | What it does |
|---|---|
| `/matthaeusheer-skills:idea2demo <idea>` | Takes a feature idea autonomously through panel grilling, spec, tickets, implementation and review to merged PRs, a running demo and an executive report. Never deploys to production. |
