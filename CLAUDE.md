# CLAUDE.md

Project-level guidance for Claude Code sessions working in this dotfiles repo.

## Commit Guidelines

All commits in this repo MUST follow both **Conventional Commits** and **Atomic Commits**.

### 1. Conventional Commits

Format:

```
<type>(<scope>): <subject>
```

- **type** — one of: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`.
- **scope** — the area touched (e.g. `nvim`, `ghostty`, `git`). Optional but strongly preferred in this repo.
- **subject** — imperative mood, lowercase, no trailing period, ≤ 72 chars.

Examples (matching the existing log style):

```
feat(ghostty): modify app icon
fix(ghostty): fix cursor-style not working
refactor(git): simplify l and lg aliases
```

### 2. Atomic Commits

Each commit represents **one** logical change. Do not bundle unrelated edits in a single commit.

- If `git status` shows changes spanning multiple concerns, split them into separate commits using `git add -p` or path-scoped `git add <file>`.
- One commit = one reason to revert. If you cannot describe the commit without using "and", it is probably not atomic.

### Example

Unstaged changes touch both Neovim and Ghostty configs.

**Wrong** — one mixed commit:

```
chore: update nvim and ghostty configs
```

**Right** — two atomic commits, each conventional:

```
feat(nvim): add shortcut to list all changed files
fix(ghostty): correct cursor-style option name
```
