# claude-code-settings

**把 Kiro 的 Steering + Spec 精神帶到 Claude Code — 全域 Skills 工具包**

讓 Claude Code 從「接收指令的工具」變成「理解專案全貌的開發夥伴」。

---

## 這是什麼？

這是一套 Claude Code 的全域 Skills、Rules 和 CLAUDE.md 配置，將 [AWS Kiro](https://aws.amazon.com/tw/events/taiwan/techblogs/kiro-featured-capabilities-book-of-kiro/) 的 **Steering**（專案知識管理）和 **Spec**（結構化開發流程）兩大核心概念，移植到 Claude Code 的原生擴展機制中。

### 解決什麼問題？

如果你用 Claude Code 開發時遇過這些情況：

- 每次開新會話都要重新解釋專案背景
- 說「做個登錄功能」，結果跟你的技術棧完全對不上
- 需求越改越亂，代碼寫到一半才發現方向錯了
- 做完功能後文檔永遠跟不上代碼

那這套工具包就是為你設計的。

### 核心理念

**Steering** — 讓 AI 從一開始就理解你的專案：產品是什麼、用了什麼技術、代碼怎麼組織、做到哪了。

**Spec** — 把模糊需求變成結構化規範，再拆成可執行的任務。不再邊寫邊猜。

```
/steering-init  →  /spec  →  開發  →  /review  →  /steering-update
   理解專案         需求→設計→任務   寫代碼     審查        同步文檔
```

---

## 快速開始

### 1. 一鍵安裝

```bash
git clone https://github.com/lloyd3126/claude-code-settings.git
cd claude-code-settings
chmod +x setup.sh
./setup.sh
```

或者手動複製文件到 `~/.claude/` 目錄（見[手動安裝](#手動安裝)）。

### 2. 初始化你的專案

```bash
cd your-project
claude
```

```
> /steering-init
```

Claude 會自動掃描你的專案，生成完整的 Steering 文件。

### 3. 開始開發

```
> /spec
> 我要開發用戶登錄功能
```

Claude 會引導你走完需求 → 設計 → 任務拆解三個階段，然後逐一執行。

---

## 包含什麼

### 全域 Skills（`~/.claude/skills/`）

| 命令 | 文件 | 功能 |
|------|------|------|
| `/spec` | `spec.md` | Spec 三階段開發流程（需求 → 設計 → 任務） |
| `/review` | `review.md` | 多維度代碼審查工作流 |
| `/steering-init` | `steering-init.md` | 為新專案初始化 Steering 文件 |
| `/steering-update` | `steering-update.md` | 功能完成後同步更新所有文檔 |

### 全域 Rules（`~/.claude/rules/`）

| 文件 | 觸發條件 | 內容 |
|------|---------|------|
| `typescript.md` | 編輯 `*.ts` / `*.tsx` | 類型安全、命名規範 |
| `git.md` | Git 相關操作 | Conventional Commits、提交規範 |

### 全域 CLAUDE.md

每次啟動 Claude Code 自動讀取的核心上下文，包含開發原則、提交規範和可用命令索引。

---

## 工作流詳解

### `/steering-init` — 初始化專案上下文

第一次在專案中使用時執行一次。Claude 會掃描你的代碼庫，自動生成四個 Steering 文件：

```
doc/steering/
├── product.md      # 產品概覽：使命、用戶、功能、業務目標
├── tech.md         # 技術棧：架構、版本、決策紀錄
├── structure.md    # 目錄結構：放置規則、命名規範
└── progress.md     # 進度總覽：功能索引、技術債、里程碑
```

同時會生成精簡的專案級 `CLAUDE.md`（< 100 行），之後每次開會話 Claude 都能立刻理解你的專案。

### `/spec` — 結構化功能開發

靈感來自 Kiro 的 Spec 模式。每個新功能走三個階段：

**階段一：Requirements（需求）**
- 用戶故事（As a / I want to / So that）
- 接受標準（EARS 語法，表格化）
- 範圍界定（In Scope / Out of Scope / Future）

**階段二：Design（技術設計）**
- 前端組件設計、狀態管理
- 後端 API、資料模型
- 安全考量、對現有系統的影響

**階段三：Implementation（任務拆解）**
- 可執行的任務清單（含依賴關係和時間預估）
- 驗收檢查清單

每個階段都需要你確認後才進入下一階段。生成的 Spec 文件保存在：

```
doc/specs/{功能名}/
├── requirements.md
├── design.md
└── tasks.md
```

### `/review` — 代碼審查

從五個維度審查代碼變更：正確性、安全性、效能、可維護性、測試覆蓋。輸出結構化的審查報告。

### `/steering-update` — 保持文檔同步

功能做完後執行。Claude 會分析 `git diff`，然後只更新有變化的部分：

| 文件 | 更新什麼 | 不做什麼 |
|------|---------|---------|
| `doc/specs/{功能名}/tasks.md` | 任務狀態標記 ✅ | — |
| `doc/steering/progress.md` | 功能索引狀態、新增技術債 | 不重複 tasks.md 的任務細節 |
| `doc/steering/tech.md` | 新依賴、版本升級、架構變更 | 不改沒變化的段落 |
| `doc/steering/structure.md` | 新目錄、結構調整 | 不改沒變化的段落 |
| `CLAUDE.md` | 狀態速覽、技術棧速覽 | 保持 < 100 行 |

---

## 文件結構

安裝後的完整結構：

```
~/.claude/                          # 全域（所有專案生效）
├── CLAUDE.md                       # 核心上下文
├── skills/
│   ├── spec.md                     # /spec
│   ├── review.md                   # /review
│   ├── steering-init.md            # /steering-init
│   └── steering-update.md          # /steering-update
└── rules/
    ├── typescript.md               # TypeScript 規則
    └── git.md                      # Git 規則

your-project/                       # 專案級（/steering-init 生成）
├── CLAUDE.md                       # 專案上下文（覆蓋全域）
├── doc/
│   ├── steering/
│   │   ├── product.md              # 產品概覽
│   │   ├── tech.md                 # 技術棧
│   │   ├── structure.md            # 目錄結構
│   │   └── progress.md             # 進度與技術債
│   └── specs/
│       └── {功能名}/
│           ├── requirements.md     # 需求定義
│           ├── design.md           # 技術設計
│           └── tasks.md            # 任務清單
```

### 設定層級

Claude Code 的設定是累加的，專案級優先：

```
┌─────────────────────────────────────┐
│  ~/.claude/          ← 全域         │  所有專案生效
├─────────────────────────────────────┤
│  your-project/.claude/ ← 專案      │  覆蓋全域同名設定
│  your-project/CLAUDE.md            │  與全域 CLAUDE.md 累加
└─────────────────────────────────────┘
```

---

## 手動安裝

如果你不想用安裝腳本，可以手動複製：

```bash
# 建立目錄
mkdir -p ~/.claude/skills ~/.claude/rules

# 複製文件
cp skills/*.md ~/.claude/skills/
cp rules/*.md ~/.claude/rules/
cp CLAUDE.md ~/.claude/CLAUDE.md
```

---

## 自定義

### 修改全域 CLAUDE.md

編輯 `~/.claude/CLAUDE.md`，加入你自己的開發偏好：

```markdown
## 我是誰
- 語言偏好：繁體中文回覆
- 角色：全棧開發者
- 偏好的測試框架：Vitest
```

### 新增專案級 Skill

在專案的 `.claude/skills/` 目錄下建立 `.md` 文件即可。例如：

```markdown
---
description: 部署到生產環境。當用戶說「部署」「上線」「deploy」時使用。
disable-model-invocation: true
---

# 部署流程
1. 執行 `pnpm test`
2. 執行 `pnpm build`
3. ...
```

### 新增 Rules

在 `~/.claude/rules/`（全域）或 `.claude/rules/`（專案）下建立 `.md` 文件：

```markdown
---
paths:
  - "prisma/**"
---

# Prisma 規則
- 修改 schema 後必須執行 `pnpm prisma generate`
- Model 命名使用 PascalCase 單數
```

---

## 設計決策

### 為什麼用 progress.md + tasks.md 而不是只用一個？

`tasks.md` 追蹤單個功能的任務細節（「第 3 個任務做完了嗎？」），`progress.md` 是全專案的鳥瞰索引（「登錄功能整體完成了嗎？」）。

`progress.md` 還負責 Spec 管不到的內容：技術債、已知問題、hotfix 紀錄、里程碑。兩者職責不重疊。

### 為什麼 /steering-init 設了 disable-model-invocation？

這個 Skill 會建立目錄和文件，有副作用。設了 `disable-model-invocation: true` 後，Claude 不會自動觸發它，只有你手動輸入 `/steering-init` 才會執行。

### 為什麼 CLAUDE.md 要控制在 100 行以內？

Claude Code 每次會話都會讀取 CLAUDE.md，太長會佔用上下文窗口，降低 Claude 的效率。詳細內容放在 Skills（按需載入）和 `doc/steering/`（用 `@path` 引用）裡。

---

## 靈感來源

本專案的 Steering 和 Spec 概念受到 **AWS Kiro** 的啟發。Kiro 是 AWS 推出的 AI IDE，其核心設計理念是用 Steering 文件讓 AI 理解專案全貌，用 Spec 流程將模糊需求結構化為可執行的開發計畫。

本專案將這些理念適配到 Claude Code 的 CLAUDE.md、Skills 和 Rules 機制中，讓不使用 Kiro 的開發者也能享受結構化 AI 開發的好處。

詳細了解 Kiro 的特色功能：[Kiro 特色功能 | Book of Kiro](https://aws.amazon.com/tw/events/taiwan/techblogs/kiro-featured-capabilities-book-of-kiro/)

---

## 授權

MIT License

---

## 貢獻

歡迎提 Issue 和 PR。如果你有好用的 Skill 或 Rule 想分享，特別歡迎。
