#!/bin/bash

# Vibe-Agent-System (VAS) Interactive Precision Linker
# Supports: Gemini, Claude Desktop, Codex

set -e

PROJECT_ROOT=$(pwd)
MANIFEST="$PROJECT_ROOT/plugin.json"
HOOKS="$PROJECT_ROOT/hooks"
SKILLS="$PROJECT_ROOT/skills"
AGENTS="$PROJECT_ROOT/agents"
VAS_CONFIG="$HOME/.agents/vas-config.json"

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
    ln -sf "$AGENTS" "$TARGET_DIR/agents"
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
    ln -sf "$AGENTS" "$TARGET_DIR/agents"
    echo "✅ Claude plugin linked to $TARGET_DIR"
}

install_codex() {
    local TARGET_DIR="$HOME/.codex/extensions/vibe-agent-system"
    echo "📦 Installing to Codex..."
    mkdir -p "$TARGET_DIR"
    ln -sf "$MANIFEST" "$TARGET_DIR/gemini-extension.json"
    ln -sf "$HOOKS" "$TARGET_DIR/hooks"
    ln -sf "$SKILLS" "$TARGET_DIR/skills"
    ln -sf "$AGENTS" "$TARGET_DIR/agents"
    echo "✅ Codex extension linked to $TARGET_DIR"
}

setup_config() {
    if [ ! -f "$VAS_CONFIG" ]; then
        echo "📝 Creating default config at $VAS_CONFIG..."
        mkdir -p "$HOME/.agents"
        echo '{"agent_path": "~/.agents/agent.md"}' > "$VAS_CONFIG"
        echo "✅ Config created. Edit $VAS_CONFIG to set your agent definition path."
    else
        echo "ℹ️  Config already exists at $VAS_CONFIG — skipping."
    fi
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

setup_config

echo ""
echo "🎉 VAS Installation complete!"
echo "Config: $VAS_CONFIG"
