# ai-ecosystem

Versioned docs, decision records, and reusable templates for Cruz Sanchez's multi-AI
workflow (Claude, ChatGPT, Gemini, Notion). This repo is **not** where work happens
day-to-day — it's the stable, versioned archive of what's already been decided or
standardized.

## System-of-Record Boundaries

| System | Role | What lives there |
|---|---|---|
| **Notion** | Control plane | Live task state, in-progress docs, active project pages, AI task queue (`Master AI Ecosystem` DB). Source of truth for *current* state. |
| **GitHub (this repo)** | Archive / stable reference | Finalized markdown, decision records, reusable templates, anything that should be versioned and diffable. Source of truth for *history* and *standards*. |
| **ChatGPT** | Strategy / research / spec | Produces specs, research summaries, strategic framing. Output gets logged to Notion, and — once stable — committed here. |
| **Claude** | Implementation | Code, technical derivations, document generation, repo scaffolding, deployment prep. Consumes specs from Notion/ChatGPT, produces implementation artifacts, commits stable output here. |
| **Gemini** | (define role as used) | — |

**Rule of thumb:** if it's still changing day-to-day, it stays in Notion. Once a
decision, template, or handoff is final and reusable, it graduates to this repo via
a commit. Nothing here should be edited live by an AI agent without Cruz's review —
this repo is not an auto-write target the way the Notion task DB is.

## Folder Structure

```
ai-ecosystem/
├── docs/          # Stable reference documentation (architecture notes, standards,
│                  # glossary, anything explanatory and long-lived)
├── templates/      # Reusable markdown templates (this file's siblings)
├── projects/       # One folder per project — finalized specs, decision records,
│                  # and handoffs that graduated out of Notion
└── automation/     # Scripts/configs for any AI-to-AI or AI-to-repo automation
                    # (e.g., sync scripts, GitHub Actions, MCP server configs)
```

## How to Use the Templates

1. Copy the relevant template from `templates/` into the right `projects/<project-name>/`
   subfolder.
2. Rename it descriptively (e.g., `2026-08-20-power-electronics-handoff.md`, not
   a second copy of `handoff-template.md`).
3. Fill in every section — don't leave template placeholders in committed files.
4. Commit with a message that states *what* graduated and *why* it's stable now,
   e.g. `docs: finalize decision record for PCB fab vendor selection`.

### Templates in this repo

- **`handoff-template.md`** — use when work passes between AI nodes (e.g., ChatGPT
  spec → Claude implementation) or between AI and Cruz. Captures what's done, what's
  next, and what context the receiver needs.
- **`decision-record-template.md`** — use for any decision worth remembering *why*
  it was made (architecture choice, vendor selection, design tradeoff). Lightweight
  ADR format.
- **`project-page-standard.md`** — the canonical structure for a project's stable
  reference doc once it graduates from a live Notion page to an archived repo page.

## Non-Goals

- This repo does not replace Notion's task tracking — don't create a parallel
  kanban here.
- This repo does not store secrets, credentials, or API keys — those stay out of
  version control entirely.
- AI nodes should propose commits (via PR or by generating file contents for Cruz
  to review) rather than pushing directly, until the workflow is trusted enough to
  automate.
