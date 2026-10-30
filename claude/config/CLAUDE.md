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
  (deleting files, force-pushing a shared branch, publishing). Approval in one
  context does not carry to the next.

## Git

- Do not commit or push unless explicitly asked.
- Never commit secrets or local-only config (`.env`, credentials, tokens).
- On a working branch, fix review feedback by amending the commit that
  introduced the problem — `git commit --amend`, or a fixup and autosquash when
  it is not `HEAD`. Do not append a follow-up commit that undoes or patches an
  earlier one in the same branch. The branch should read as if the feedback had
  never been needed, because the commit that lands on the main branch is the one
  a future reader bisects to, and "fix review comment" tells them nothing.
  A project that forbids rewriting history on an open pull request overrides
  this.
- It is generally OK to use `git fpush` (an alias for
  `git push --force-with-lease`) to force push against working branches without
  asking first. Never force push the main branch or a branch other people push
  to.
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
    7. Use the body for the _why_, and only the _why_. The _what_ is
       already in the subject line and the diff; the _how_ is the diff.
- Keep bodies short. One or two sentences of rationale is usually the
  right length. Boilerplate and setup work needs less, not more.
- End the body with a line referencing the issue. The form is the word `Issue`,
  the issue number, then the issue's real title — nothing else. No braces,
  brackets, quotes, or other punctuation wrapping either part. Look the title up
  rather than guessing it.

    ```
    Issue #142 Fix login redirect loop
    ```

    Not `Issue #142 {Fix login redirect loop}` — any placeholder markup in these
    instructions indicates text to replace, and never appears in the output.

    This line is body copy, not a trailer. It is the last thing a human reads,
    so it closes the prose — it is not a metadata field, and it does not take a
    `Key: value` form. The trailer block (`Co-Authored-By:`, `Claude-Session:`,
    `Signed-off-by:`, and anything else machine-parsed) follows it, separated by
    a blank line, and is always the true end of the message:

    ```
    Use the body to explain what changed and why.

    Issue #142 Fix login redirect loop

    Co-Authored-By: ...
    Claude-Session: ...
    ```

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
- Avoid code comments; write self-documenting code instead. The urge to write
  a comment is a signal to reconsider the code: if it is complex enough to need
  explaining, extract a well-named helper function, constant, or variable that
  says it. Rationale that still needs saying belongs in the project's docs or
  the commit message, not in the code.
