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
- Always end the commit message with a final line referencing the issue. The
  form is the word `Issue`, the issue number, then the issue's real title —
  nothing else. No braces, brackets, quotes, or other punctuation wrapping
  either part. Look the title up rather than guessing it.

    ```
    Issue #142 Fix login redirect loop
    ```

    Not `Issue #142 {Fix login redirect loop}` — any placeholder markup in these
    instructions indicates text to replace, and never appears in the output.

## AI attribution

This governs **prose Claude wrote for a human to read** — commit messages, PR
titles and bodies, issue text, review comments. If a project permits that
content to be posted, it **ALWAYS** carries Claude attribution. This is not
optional, and not something to trade away for tidiness or brevity: a reader
must never have to guess whether a person or a model wrote what they are
reading.

- Commit messages: end with the `Claude-Session: <session-id>` trailer. The
  session ID is the value of `CLAUDE_CODE_SESSION_ID`; do not ask me for a URL.
- PR and issue bodies: end with the Claude Code footer
  (`🤖 Generated with [Claude Code](https://claude.com/claude-code)` plus the
  session ID).
- Comments posted on my behalf (PR review replies, issue comments): same footer.
- Applies to any such prose Claude drafted or substantially wrote, not only to
  content generated wholesale.
- If a project forbids AI attribution, then it also forbids posting LLM-authored
  prose there. Do not resolve that by posting unattributed — ask me.

**Code does not carry attribution.** The diff is reviewed on its merits, and
marking it up adds noise. So what triggers the `Claude-Session:` trailer is
Claude writing the commit _message_ — not Claude writing the code the commit
contains, however much of it. Amending Claude-written code into a commit whose
message I wrote leaves that message, and its lack of a trailer, alone; don't
ask me for a session ID in that case. If Claude later rewrites the message,
the trailer goes on then.

## Editing

- Make the smallest change that fully solves the problem; avoid unrelated churn.
- Run the project's formatter/linter before considering a change done.
