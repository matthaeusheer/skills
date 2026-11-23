---
name: idea2demo
description: Take a feature idea autonomously to merged code, a running demo and an executive report (panel grilling, spec, tickets, implement, review, merge).
disable-model-invocation: true
argument-hint: <feature idea>
---

# idea2demo

Take this idea to merged code on a clean default branch, a running demo and an executive report:

> $ARGUMENTS

Run **autonomously**: the user handed over the idea and walked away. Wherever a pipeline skill asks the user to confirm, answer or approve, the persona panel decides instead and the decision goes into the decision log for the report.

Guardrails:

- The demo is local, or staging when the repo has a staging target. Production stays untouched.
- Everything lands through PRs, following the repo's git rules and hooks.
- When one line of work is blocked (a missing secret, CI you cannot get green), park it, carry on with the rest, and list it under State in the report.

## Pipeline skills

The steps run skills from `mattpocock-skills`. Load `grilling`, `domain-modeling`, `tdd` and `code-review` with the Skill tool. `to-spec`, `to-tickets` and `implement` are user-invoked, so read their SKILL.md instead; this prints its path:

```sh
${CLAUDE_SKILL_DIR}/scripts/skill-path.sh <skill-name>
```

## 1. Context

Read the repo's `AGENTS.md`/`CLAUDE.md`, README, glossary, ADRs and the docs they point to, then the code the idea touches. Pin down:

- the issue tracker: `docs/agents/issue-tracker.md` if present, else GitHub Issues when `origin` is on GitHub, else local `.scratch/`
- the git rules: branch naming, worktrees, merge method
- the test, typecheck and lint commands
- how this repo runs a demo, and whether it has a staging target

Done when you can name the modules the idea touches, the test seam, and the demo command.

## 2. Blocking questions

List every open question. Send each one you can settle from code, docs or a sensible default to the panel. Ask the user only where a wrong guess would waste the run: product intent, scope, or an external dependency only they can provide (an account, a secret, a paid service). Ask those in a single AskUserQuestion round, recommended answer first, or skip the step when there are none. This is the run's only planned stop.

## 3. Panel grilling

Run grill-with-docs: load `grilling` and `domain-modeling`. The grilling is a **panel** conversation: three personas grill each other instead of the user.

- **PM**: user value, scope, the smallest version worth shipping, what is explicitly out.
- **UI/UX specialist**: flows, states (empty, loading, error, success), accessibility, fit with the repo's UI rules.
- **Architect**: modules, seams, data, security and abuse, failure modes, fit with the ADRs.

Each round shows the frontier questions, each persona's position, and the decision. Write glossary and ADR updates as `domain-modeling` directs, on a docs branch; open its PR and merge it before step 5 so every ticket starts with the docs.

Done when the design tree has no open frontier: every decision is made or explicitly out of scope.

## 4. Spec and tickets

Follow `to-spec`, then `to-tickets`, publishing to the tracker from step 1. The Architect confirms the test seams; the panel approves the ticket breakdown.

Done when the spec and every ticket exist on the tracker, with blocking edges.

## 5. Implement

Work the ticket **frontier**: every ticket whose blockers are merged. Spawn one subagent per frontier ticket with worktree isolation; independent tickets run in parallel. Brief each subagent to:

1. start from the freshly fetched default branch
2. follow `implement` (give it the SKILL.md path), which runs `tdd` and `code-review`
3. run the repo's tests, typecheck and linters
4. push a branch named by the repo's convention and open a PR that closes its ticket
5. report the PR URL, the checks run and the review findings

Review each PR yourself: CI green, review findings fixed, acceptance criteria met. Merge it with the repo's merge method, then start the tickets it unblocks. On a conflict, rebase the ticket branch onto the default branch, resolve, rerun the tests and push.

Done when every ticket's PR is merged and its issue closed.

## 6. Demo

Bring up the demo from the updated default branch the way the repo does it: a local run (respecting the host's dev-server and port rules) or a staging deploy. Verify the feature end to end in it; for UI, script the flow with Playwright and keep a screenshot.

Done when the feature is verified in the running demo and you have its URL or run command.

## 7. Clean up

Remove the worktrees and local branches the run created, delete its merged remote branches, and stop every process it started except the demo.

Done when `git worktree list`, `git branch` and the process list show nothing left from the run.

## 8. Report

Post the executive summary as a comment on the spec issue, then print it:

- **Shipped**: merged PRs and closed tickets
- **Demo**: URL or run command, and how to stop it
- **Decisions**: each panel decision with a one-line why; mark the ones worth revisiting
- **Assumptions**: what was decided without asking the user
- **State**: parked work, follow-up issues, known gaps

Keep it readable in under a minute.
