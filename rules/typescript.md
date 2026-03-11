---
paths:
  - "**/*.ts"
  - "**/*.tsx"
---

# TypeScript 通用規則

- 禁止使用 `any`，必須定義明確類型
- 優先使用 `interface` 而非 `type`（除非需要 union/intersection type）
- 組件 props 定義為 `{組件名}Props` interface
- 所有 export 的函數必須有明確的返回類型
- 使用 `as const` 代替 enum（除非有明確理由）
