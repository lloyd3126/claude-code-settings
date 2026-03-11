---
paths:
  - ".git/**"
  - "**/.gitignore"
---

# Git 規則

- 提交信息使用 Conventional Commits 格式
- 每次提交前確認 `git diff --staged` 的內容
- 不要將 .env、node_modules、.claude/worktrees/ 提交到版本控制
- 大型重構拆分為多個小提交，每個提交保持可編譯
