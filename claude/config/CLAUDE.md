# Personal Global Instructions

These preferences apply across every project. Project-level `CLAUDE.md` files
take precedence where they conflict.

## Working style

- Lead with the answer or result, then the supporting detail. Keep prose tight.
- Verify claims before stating them. Prefer reading the code/docs over recalling
  from memory, and cite `file:line` when referring to specific code.
- Match the conventions already present in a repo (naming, formatting, structure)
  rather than imposing new ones.
- Ask before doing anything destructive, hard to reverse, or outward-facing
  (deleting files, force-pushing, publishing). Approval in one context does not
  carry to the next.

## Git

- Do not commit or push unless explicitly asked.
- Never commit secrets or local-only config (`.env`, credentials, tokens).
- Follow the repo's own commit conventions where they exist (e.g. Conventional
  Commits, changelog tags, issue references). Repo rules win on conflict.
- Otherwise, follow the seven rules of a great commit message
  (https://cbea.ms/git-commit/):
    1. Separate subject from body with a blank line.
    2. Limit the subject line to 50 characters.
    3. Capitalize the subject line.
    4. Do not end the subject line with a period.
    5. Use the imperative mood in the subject line ("Add x", not "Added x").
    6. Wrap the body at 72 characters.
    7. Use the body to explain _what_ and _why_ vs. _how_.
- Always end the commit message with a final line referencing the issue:
  `Issue #XXX {actual issue title here}` — replace `XXX` with the issue number
  and put the issue's real title inside the braces (e.g.
  `Issue #142 {Fix login redirect loop}`). Look up the actual title rather than
  guessing.

## Editing

- Make the smallest change that fully solves the problem; avoid unrelated churn.
- Run the project's formatter/linter before considering a change done.
