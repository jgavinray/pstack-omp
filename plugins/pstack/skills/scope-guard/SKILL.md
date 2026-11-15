---
name: scope-guard
description: Use before any edit to a protected config path, when a task names omp agent config, models.yml, mcp.json, crush config, or secrets files. Forces a field-level enumeration of the user mandate and surfaces an advisory adjudicator verdict. Never blocks; it nudges.
disable-model-invocation: true
---

# Scope guard

Read `skill://pstack-omp` for the delegation contract this skill lives under.

## Non-negotiables

Protected paths. Edit only the fields the user named verbatim this session:

- `~/.omp/agent/config.yml`
- `~/.omp/agent/models.yml`
- `~/.omp/agent/mcp.json`
- `~/.config/crush/`
- `secrets.env`

This is a deliberate carve-out from **principle-never-block-on-the-human**: a
protected-path edit is demoted out of the reversible-work class the way
`poteto-mode`'s Always-pause list demotes merges and pushes. The user request
may name a domain ("route my models through aperture") without naming fields.
The domain being named does not authorize the fields. Enumerate before editing.

Any edit under a protected path routes to `playbooks/protected-edit.md` before
the first `edit` call. No autonomy grant waives it.

## The gate is advisory

`scripts/scope-check.sh` never blocks and never exits nonzero. It prints one
advisory line from the lfm2d adjudicator (`specs/edit-scope-verdict-v1.json`).
When the adjudicator is unreachable the script says so and the enumeration
table becomes the only check. That degradation is by design: hard gates make
the harness brittle, so this skill raises the cost of silent drift instead of
refusing the write. The cost is the reply contract: the verdict, the user's
verbatim quote, and the backup path appear in the final reply, so a widening
edit ships self-documenting and a missing scope-guard line on a protected-path
edit is the signal the skill did not fire.
