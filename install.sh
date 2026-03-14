#!/bin/bash

# Vibe-Agent-System (VAS) Precision Linker
# Automates symbolic linking for Gemini, Claude, and Codex environments.

set -e

PROJECT_ROOT=$(pwd)
MANIFEST="$PROJECT_ROOT/plugin.json"
HOOKS="$PROJECT_ROOT/hooks"
SKILLS="$PROJECT_ROOT/skills"

echo "🚀 VAS Precision Linker starting..."

# --- 1. Gemini / Codex Setup ---
GEMINI_DIR="$HOME/.gemini/extensions/vibe-agent-system"
echo -n "Checking for Gemini/Codex... "
if [ -d "$HOME/.gemini" ]; then
    echo "Found."
    mkdir -p "$GEMINI_DIR"
    ln -sf "$MANIFEST" "$GEMINI_DIR/gemini-extension.json"
    ln -sf "$HOOKS" "$GEMINI_DIR/hooks"
    ln -sf "$SKILLS" "$GEMINI_DIR/skills"
    echo "✅ Gemini extension linked to $GEMINI_DIR"
else
    echo "Skipped (not found)."
fi

# --- 2. Claude Desktop Setup ---
CLAUDE_DIR="$HOME/.claude/plugins/vibe-agent-system"
CLAUDE_MANIFEST_DIR="$CLAUDE_DIR/.claude-plugin"
echo -n "Checking for Claude Desktop... "
if [ -d "$HOME/.claude" ]; then
    echo "Found."
    mkdir -p "$CLAUDE_MANIFEST_DIR"
    ln -sf "$MANIFEST" "$CLAUDE_MANIFEST_DIR/plugin.json"
    ln -sf "$HOOKS" "$CLAUDE_DIR/hooks"
    ln -sf "$SKILLS" "$CLAUDE_DIR/skills"
    echo "✅ Claude plugin linked to $CLAUDE_DIR"
else
    echo "Skipped (not found)."
fi

echo "🎉 VAS Installation complete! Don't forget to set VAS_AGENT_PATH."
