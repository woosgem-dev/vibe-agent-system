#!/bin/bash

# Vibe-Agent-System (VAS) Interactive Precision Linker
# Supports: Gemini, Claude Desktop, Codex

set -e

PROJECT_ROOT=$(pwd)
MANIFEST="$PROJECT_ROOT/plugin.json"
HOOKS="$PROJECT_ROOT/hooks"
SKILLS="$PROJECT_ROOT/skills"

echo "🚀 VAS Interactive Precision Linker starting..."
echo "Please select the environments you want to install VAS into (e.g., 1,2):"
echo "1) Gemini (~/.gemini)"
echo "2) Claude Desktop (~/.claude)"
echo "3) Codex (~/.codex)"
echo "4) All of the above"
echo "q) Quit"

read -p "Selection: " choice

install_gemini() {
    local TARGET_DIR="$HOME/.gemini/extensions/vibe-agent-system"
    echo "📦 Installing to Gemini..."
    mkdir -p "$TARGET_DIR"
    ln -sf "$MANIFEST" "$TARGET_DIR/gemini-extension.json"
    ln -sf "$HOOKS" "$TARGET_DIR/hooks"
    ln -sf "$SKILLS" "$TARGET_DIR/skills"
    echo "✅ Gemini extension linked to $TARGET_DIR"
}

install_claude() {
    local TARGET_DIR="$HOME/.claude/plugins/vibe-agent-system"
    local MANIFEST_DIR="$TARGET_DIR/.claude-plugin"
    echo "📦 Installing to Claude Desktop..."
    mkdir -p "$MANIFEST_DIR"
    ln -sf "$MANIFEST" "$MANIFEST_DIR/plugin.json"
    ln -sf "$HOOKS" "$TARGET_DIR/hooks"
    ln -sf "$SKILLS" "$TARGET_DIR/skills"
    echo "✅ Claude plugin linked to $TARGET_DIR"
}

install_codex() {
    local TARGET_DIR="$HOME/.codex/extensions/vibe-agent-system"
    echo "📦 Installing to Codex..."
    mkdir -p "$TARGET_DIR"
    ln -sf "$MANIFEST" "$TARGET_DIR/gemini-extension.json"
    ln -sf "$HOOKS" "$TARGET_DIR/hooks"
    ln -sf "$SKILLS" "$TARGET_DIR/skills"
    echo "✅ Codex extension linked to $TARGET_DIR"
}

case $choice in
    *1*) install_gemini ;;
esac

case $choice in
    *2*) install_claude ;;
esac

case $choice in
    *3*) install_codex ;;
esac

if [[ "$choice" == "4" ]]; then
    install_gemini
    install_claude
    install_codex
fi

if [[ "$choice" == "q" ]]; then
    echo "Installation cancelled."
    exit 0
fi

echo ""
echo "🎉 VAS Installation process finished!"
echo "Don't forget to set VAS_AGENT_PATH in your environment or extension settings."
