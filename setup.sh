#!/bin/bash
# setup.sh — 一鍵安裝 Claude Code Steering + Spec 全域配置

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "🚀 Claude Code Steering + Spec 安裝程式"
echo "========================================="
echo ""

# 檢查 ~/.claude 目錄
if [ -f ~/.claude/CLAUDE.md ]; then
    echo "⚠️  偵測到已有 ~/.claude/CLAUDE.md"
    read -p "   要備份並覆蓋嗎？(y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        BACKUP_DIR=~/.claude/backup-$(date +%Y%m%d-%H%M%S)
        mkdir -p "$BACKUP_DIR"
        cp ~/.claude/CLAUDE.md "$BACKUP_DIR/"
        [ -d ~/.claude/skills ] && cp -r ~/.claude/skills "$BACKUP_DIR/"
        [ -d ~/.claude/rules ] && cp -r ~/.claude/rules "$BACKUP_DIR/"
        echo "   ✅ 已備份到 $BACKUP_DIR"
    else
        echo "   ❌ 安裝取消"
        exit 0
    fi
fi

# 建立目錄
echo "📁 建立目錄結構..."
mkdir -p ~/.claude/skills
mkdir -p ~/.claude/rules

# 複製文件
echo "📝 安裝全域 CLAUDE.md..."
cp "$SCRIPT_DIR/CLAUDE.md" ~/.claude/CLAUDE.md

echo "📝 安裝 Skills..."
for skill_dir in "$SCRIPT_DIR/skills"/*/; do
    skill_name=$(basename "$skill_dir")
    mkdir -p ~/.claude/skills/"$skill_name"
    cp -r "$skill_dir"* ~/.claude/skills/"$skill_name"/
done

echo "📝 安裝 Rules..."
cp "$SCRIPT_DIR/rules/"*.md ~/.claude/rules/

echo ""
echo "✅ 安裝完成！文件結構如下："
echo ""
echo "~/.claude/"
echo "├── CLAUDE.md                  # 全域上下文（每次會話自動讀取）"
echo "├── skills/"
echo "│   ├── spec/SKILL.md         # /spec — Spec 三階段開發流程"
echo "│   ├── review/SKILL.md       # /review — 代碼審查工作流"
echo "│   ├── steering-init/SKILL.md  # /steering-init — 初始化專案 Steering"
echo "│   └── steering-update/SKILL.md  # /steering-update — 功能完成後更新 Steering"
echo "└── rules/"
echo "    ├── typescript.md          # *.ts/*.tsx 文件規則"
echo "    └── git.md                 # Git 相關規則"
echo ""
echo "📌 使用方式："
echo "  cd any-project && claude     # 自動載入全域設定"
echo "  /steering-init               # 為新專案初始化 Steering 文件"
echo "  /spec                        # 啟動 Spec 三階段開發流程"
echo "  /review                      # 代碼審查"
echo "  /steering-update             # 功能完成後更新 Steering 文件"
echo ""
