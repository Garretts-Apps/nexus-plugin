#!/bin/bash
# NEXUS VM Manager - SOC 2 Type II Compliant Execution Environment
#
# Manages lifecycle of isolated VM for NEXUS plugin execution.
# User's machine → VM (SOC 2) → Docker → Claude CLI → NEXUS Agents
#
# Usage:
#   ./vm-manager.sh setup     # Install Multipass and create VM
#   ./vm-manager.sh start     # Start the VM
#   ./vm-manager.sh stop      # Stop the VM
#   ./vm-manager.sh exec      # Execute command in VM+Docker
#   ./vm-manager.sh destroy   # Delete the VM

set -euo pipefail

VM_NAME="nexus-sandbox"
VM_CPUS="2"
VM_MEM="4G"
VM_DISK="20G"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VM_DIR="$(dirname "$SCRIPT_DIR")/vm"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $*"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $*"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $*"
}

# Check if Multipass is installed
check_multipass() {
    if ! command -v multipass &> /dev/null; then
        log_error "Multipass not installed"
        log_info "Installing Multipass..."

        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS
            if command -v brew &> /dev/null; then
                brew install multipass
            else
                log_error "Homebrew not found. Install Multipass from: https://multipass.run"
                exit 1
            fi
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            # Linux
            sudo snap install multipass
        else
            log_error "Unsupported OS. Install Multipass from: https://multipass.run"
            exit 1
        fi
    fi
    log_info "Multipass installed: $(multipass version)"
}

# Create and provision VM
setup_vm() {
    log_info "Setting up NEXUS sandbox VM..."
    check_multipass

    if multipass list | grep -q "$VM_NAME"; then
        log_warn "VM $VM_NAME already exists. Use 'destroy' to remove it first."
        return 0
    fi

    log_info "Creating VM with SOC 2 Type II hardening..."
    multipass launch \
        --name "$VM_NAME" \
        --cpus "$VM_CPUS" \
        --memory "$VM_MEM" \
        --disk "$VM_DISK" \
        --cloud-init "$VM_DIR/cloud-init.yaml" \
        22.04

    log_info "Waiting for VM to be ready..."
    sleep 30

    log_info "VM ready! Testing Docker..."
    multipass exec "$VM_NAME" -- docker ps

    log_info "✅ NEXUS sandbox VM created successfully"
}

# Start VM
start_vm() {
    log_info "Starting NEXUS sandbox VM..."
    check_multipass

    if ! multipass list | grep -q "$VM_NAME"; then
        log_error "VM $VM_NAME does not exist. Run 'setup' first."
        exit 1
    fi

    multipass start "$VM_NAME"
    log_info "✅ VM started"
}

# Stop VM
stop_vm() {
    log_info "Stopping NEXUS sandbox VM..."
    multipass stop "$VM_NAME" || true
    log_info "✅ VM stopped"
}

# Destroy VM
destroy_vm() {
    log_warn "Destroying NEXUS sandbox VM..."
    multipass delete "$VM_NAME" || true
    multipass purge || true
    log_info "✅ VM destroyed"
}

# Execute command in VM+Docker
exec_in_vm() {
    local prompt="$1"
    local project_dir="${2:-.}"

    log_info "Executing in isolated VM+Docker environment..."

    # Ensure VM is running
    if ! multipass list | grep "$VM_NAME" | grep -q "Running"; then
        log_info "Starting VM..."
        start_vm
    fi

    # Transfer project to VM (excluding .git, node_modules, etc.)
    log_info "Transferring project files to VM..."
    multipass exec "$VM_NAME" -- rm -rf /tmp/workspace
    multipass exec "$VM_NAME" -- mkdir -p /tmp/workspace
    multipass transfer "$project_dir" "$VM_NAME:/tmp/workspace/" \
        --exclude=".git" \
        --exclude="node_modules" \
        --exclude=".venv" \
        --exclude="__pycache__"

    # Execute in Docker container inside VM
    log_info "Running in Docker container..."
    multipass exec "$VM_NAME" -- docker run --rm \
        -v /tmp/workspace:/workspace \
        -e ANTHROPIC_API_KEY="${ANTHROPIC_API_KEY:-}" \
        --security-opt=no-new-privileges \
        --cap-drop=ALL \
        --network=bridge \
        --memory=2g \
        --cpus=1 \
        nexus-cli-sandbox \
        "$prompt"

    # Transfer results back
    log_info "Transferring results back..."
    multipass transfer "$VM_NAME:/tmp/workspace/" "$project_dir/"

    log_info "✅ Execution complete"
}

# Get VM status
status_vm() {
    log_info "NEXUS sandbox VM status:"
    multipass list | grep "$VM_NAME" || echo "VM not found"
}

# Main command dispatcher
case "${1:-}" in
    setup)
        setup_vm
        ;;
    start)
        start_vm
        ;;
    stop)
        stop_vm
        ;;
    destroy)
        destroy_vm
        ;;
    exec)
        exec_in_vm "${2:-}" "${3:-.}"
        ;;
    status)
        status_vm
        ;;
    *)
        echo "Usage: $0 {setup|start|stop|destroy|exec|status}"
        echo ""
        echo "Commands:"
        echo "  setup    - Install Multipass and create VM"
        echo "  start    - Start the VM"
        echo "  stop     - Stop the VM"
        echo "  destroy  - Delete the VM"
        echo "  exec     - Execute command in VM+Docker"
        echo "  status   - Show VM status"
        exit 1
        ;;
esac
