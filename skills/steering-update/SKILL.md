---
name: steering-update
description: 功能完成後更新 Steering 文件。當用戶說「更新 steering」「同步文檔」「功能做完了」「更新進度」或完成了 Spec 任務清單的所有任務時使用。
---

# 更新 Steering 文件

當一個功能開發完成（或階段性完成）後，執行以下步驟確保文檔與代碼同步。

## 職責分工（重要）

| 文件 | 負責什麼 | 不負責什麼 |
|------|---------|----------|
| `doc/specs/{功能名}/tasks.md` | 單個功能的任務細節和狀態 | 全專案鳥瞰 |
| `doc/steering/progress.md` | 全專案功能索引、技術債、非 Spec 變更 | 任務級別的細節 |

**不要在 progress.md 裡重複 tasks.md 已經記錄的任務細節。**

---

## 第一步：確認變更範圍

```bash
git diff main --stat
git log --oneline -20
```

同時檢查是否有：新增依賴、目錄結構變化、Schema 變更、新的環境變數。

## 第二步：更新 Spec 文件（如走了 Spec 流程）

- 更新 `doc/specs/{功能名}/tasks.md` 中各任務的狀態為 ✅
- 確認驗收檢查清單所有項目都已完成並打勾

## 第三步：更新 progress.md（必更新）

只更新以下段落：

### 功能狀態一覽表
- 更新對應功能的狀態（⬜ → 🔧 → ✅）
- 新功能加入表格，附上 Spec 路徑（如有）
- 格式：

```markdown
| 功能 | 狀態 | Spec 路徑 |
|------|------|----------|
| 用戶登錄 | ✅ 完成 | doc/specs/user-login/tasks.md |
```

### 技術債 / 已知問題
- 如開發過程中發現新的技術債或遺留問題，加入此段落
- 已解決的問題標記日期並移至「已解決」

### 非 Spec 的修復與改進紀錄
- 如本次變更不是走 Spec 流程的（hotfix、小重構等），記錄在這裡

## 第四步：按需更新其他 Steering 文件

以下文件只在相關內容有變化時更新（只改有變化的部分，不重寫整個文件）：

### `doc/steering/product.md`
- 更新「當前進度」表格中對應模組的狀態
- 如新增了核心功能，加入功能列表

### `doc/steering/tech.md`
- 如新增了依賴或升級了版本，更新版本號
- 如架構有變化，更新架構描述
- 如做了重要技術決策，加入「架構決策紀錄」

### `doc/steering/structure.md`
- 如新增了重要目錄或改變了組織方式，更新目錄樹

### 專案 `CLAUDE.md`
- 如技術棧速覽或當前狀態有變化，同步更新
- 保持精簡，不超過 100 行

## 第五步：輸出變更摘要

| 文件 | 變更內容 | 變更原因 |
|------|---------|---------|
| doc/specs/user-login/tasks.md | 所有任務標記 ✅ | 功能開發完成 |
| doc/steering/progress.md | 用戶登錄狀態更新為 ✅ | 同步一覽表 |
| doc/steering/tech.md | 新增 bcrypt 依賴 | 密碼哈希需求 |
| ... | ... | ... |

> 💡 **建議**：更新完成後，用獨立 commit 提交：
> `git add doc/ CLAUDE.md && git commit -m "docs: update steering after {功能名} completion"`
