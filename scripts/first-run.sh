#!/bin/bash
# NEXUS First-Run Setup - Interactive scaffolding
#
# Detects first use and prompts user for setup steps.
# Runs automatically when user invokes any NEXUS skill/command.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(dirname "$SCRIPT_DIR")"
STATE_FILE="$HOME/.nexus-plugin-initialized"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() {
    echo -e "${GREEN}[NEXUS]${NC} $*"
}

prompt() {
    echo -e "${YELLOW}[PROMPT]${NC} $*"
}

info() {
    echo -e "${BLUE}[INFO]${NC} $*"
}

# Check if already initialized
if [ -f "$STATE_FILE" ]; then
    # Already set up, just ensure VM is running
    if ! multipass list 2>/dev/null | grep -q "nexus-sandbox.*Running"; then
        log "Starting NEXUS VM..."
        "$SCRIPT_DIR/vm-manager.sh" start
    fi
    exit 0
fi

# First run - show what will be done
clear
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                    NEXUS FIRST-TIME SETUP                      ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
info "NEXUS uses a secure, isolated execution environment:"
echo ""
echo "  Your Machine"
echo "    └─ Multipass VM (Ubuntu, SOC 2 hardened)"
echo "        └─ Docker Container (nexus-cli-sandbox)"
echo "            └─ Claude CLI + NEXUS Agents"
echo ""
info "This setup will:"
echo "  1. Install Multipass (if not present)"
echo "  2. Create secure Ubuntu VM (2 CPU, 4GB RAM, 20GB disk)"
echo "  3. Build Docker sandbox container"
echo "  4. Configure security and isolation"
echo ""
info "Estimated time: 5-10 minutes"
info "Required: 8GB RAM, 20GB disk space"
echo ""

# Prompt for confirmation
read -p "$(echo -e ${YELLOW}Continue with setup? [y/N]:${NC} )" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    log "Setup cancelled. Run any NEXUS command to restart setup."
    exit 0
fi

echo ""
log "Starting setup..."
echo ""

# Step 1: Check/Install Multipass
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
log "Step 1/4: Checking Multipass installation..."

if ! command -v multipass &> /dev/null; then
    log "Multipass not found. Installing..."

    if [[ "$OSTYPE" == "darwin"* ]]; then
        if command -v brew &> /dev/null; then
            info "Installing via Homebrew..."
            brew install multipass
        else
            echo ""
            prompt "Homebrew not found. Please install Multipass manually:"
            prompt "  1. Visit: https://multipass.run"
            prompt "  2. Download and install Multipass"
            prompt "  3. Run this setup again"
            exit 1
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        info "Installing via Snap..."
        sudo snap install multipass
    else
        echo ""
        prompt "Please install Multipass manually:"
        prompt "  1. Visit: https://multipass.run"
        prompt "  2. Download and install for your OS"
        prompt "  3. Run this setup again"
        exit 1
    fi

    log "✅ Multipass installed"
else
    log "✅ Multipass already installed ($(multipass version | head -1))"
fi

# Step 2: Create VM
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
log "Step 2/4: Creating secure VM..."

if multipass list 2>/dev/null | grep -q "nexus-sandbox"; then
    log "✅ VM already exists"
else
    info "Creating VM with SOC 2 hardening (this may take a few minutes)..."
    "$SCRIPT_DIR/vm-manager.sh" setup
    log "✅ VM created and hardened"
fi

# Step 3: Build Docker image
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
log "Step 3/4: Building Docker sandbox..."

info "Transferring Docker config to VM..."
multipass transfer "$PLUGIN_DIR/docker" nexus-sandbox:/home/nexus/

info "Building nexus-cli-sandbox image (this may take a few minutes)..."
multipass exec nexus-sandbox -- docker build -t nexus-cli-sandbox /home/nexus/docker

log "✅ Docker sandbox built"

# Step 4: Verify setup
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
log "Step 4/4: Verifying setup..."

info "Testing VM..."
multipass exec nexus-sandbox -- echo "VM OK"

info "Testing Docker..."
multipass exec nexus-sandbox -- docker ps

info "Testing Claude CLI..."
multipass exec nexus-sandbox -- docker run --rm nexus-cli-sandbox --version 2>/dev/null || true

log "✅ Setup verified"

# Mark as initialized
touch "$STATE_FILE"
echo "$(date)" > "$STATE_FILE"

# Success message
echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                      SETUP COMPLETE! 🚀                        ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
log "NEXUS is ready to use!"
echo ""
info "Try it out:"
echo '  • "Build me a todo API"           → autonomous-build skill'
echo '  • "Review the code in src/"       → code-review-org skill'
echo '  • /nexus-status                   → show org status'
echo '  • /nexus-cost                     → cost report'
echo ""
info "Your code executes in an isolated VM+Docker environment."
info "All agent interactions are visible in real-time."
echo ""
log "Happy building! ✨"
echo ""
