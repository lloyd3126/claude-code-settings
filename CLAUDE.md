# 全域開發規範

## 我是誰
- 語言偏好：繁體中文回覆
- 角色：全棧開發者

## 核心開發原則
- 新功能必須走 Spec 流程（使用 /spec 命令）
- 所有代碼變更必須有對應測試
- 提交前必須通過 lint 和 type check
- 遵循各專案的 CLAUDE.md 中定義的技術棧和規範

## 可用的全域命令
- `/spec` — 啟動 Spec 三階段開發流程（需求 → 設計 → 任務）
- `/review` — 代碼審查工作流
- `/steering-init` — 為當前專案初始化 Steering 文件
- `/steering-update` — 功能完成後更新 Steering 文件（同步進度、技術棧、結構）

## 提交規範
使用 Conventional Commits 格式：
- feat: 新功能
- fix: 修復
- refactor: 重構
- test: 測試
- docs: 文檔
- chore: 雜項
