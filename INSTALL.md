# NEXUS Plugin Installation Guide

## Architecture Overview

NEXUS plugin uses a secure, isolated execution environment for SOC 2 Type II compliance:

```
Your Machine
  └─ Multipass VM (Ubuntu 22.04, SOC 2 hardened)
      └─ Docker Container (nexus-cli-sandbox)
          └─ Claude CLI + NEXUS Agents
              └─ Stream output back to you
```

**Why this architecture?**
- **Isolation**: Your code never runs directly on your machine
- **Security**: SOC 2 Type II compliant VM with hardened Docker containers
- **Sanitation**: All execution happens in a sandboxed environment
- **Transparency**: You see all agent interactions in real-time

## Prerequisites

1. **Claude Code CLI** (required)
   ```bash
   npm install -g @anthropic-ai/claude-code
   ```

2. **Multipass** (auto-installed by plugin if missing)
   - macOS: Installed via Homebrew
   - Linux: Installed via Snap
   - Windows: Downloaded from multipass.run

3. **System Requirements**
   - 8GB RAM minimum (4GB for VM + 4GB for host)
   - 20GB free disk space
   - Internet connection for initial setup

## Installation Methods

### Method 1: Via Claude Code Marketplace (Recommended)

1. Open Claude Code
2. Type `/plugin`
3. Add marketplace source:
   ```
   https://github.com/Garrett-s-Apps/nexus-plugin
   ```
4. Select "NEXUS" and click Install
5. Restart Claude Code
6. **First-time setup** (automatic on first use):
   ```bash
   # Plugin will automatically:
   # 1. Install Multipass (if not present)
   # 2. Create secure VM
   # 3. Build Docker container
   # 4. Configure isolation

   # Takes ~5-10 minutes on first run
   ```

### Method 2: Manual Installation

```bash
# Clone to Claude Code plugins directory
git clone https://github.com/Garrett-s-Apps/nexus-plugin.git ~/.claude/plugins/nexus

# Run first-time setup
cd ~/.claude/plugins/nexus
./scripts/vm-manager.sh setup

# Restart Claude Code
```

## Verification

After installation, verify everything works:

```bash
# Check VM status
cd ~/.claude/plugins/nexus
./scripts/vm-manager.sh status

# Should show:
# NEXUS sandbox VM status:
# Name                    State             IPv4             Image
# nexus-sandbox          Running           10.x.x.x         Ubuntu 22.04 LTS
```

Test the plugin:
```
# In Claude Code, say:
"Build me a hello world API"

# Plugin will:
# 1. Start VM (if stopped)
# 2. Execute in Docker container
# 3. Stream output back to you
# 4. Show cost and files created
```

## Configuration

### Environment Variables

```bash
# Required: Your Anthropic API key (plugin uses your Claude subscription by default)
export ANTHROPIC_API_KEY=sk-ant-...

# Optional: Budget limits
export NEXUS_HOURLY_TARGET=1.00       # Soft limit per hour
export NEXUS_HOURLY_CAP=2.50          # Hard limit per hour
export NEXUS_MONTHLY_TARGET=160.00    # Monthly budget target
```

### VM Resource Limits

Default VM configuration (can be customized in `scripts/vm-manager.sh`):
- **CPUs**: 2 cores
- **Memory**: 4GB RAM
- **Disk**: 20GB storage
- **Network**: Isolated (only HTTPS out for API calls)

### Security Settings

SOC 2 Type II compliance features:
- ✅ **Audit logging**: All Docker operations logged
- ✅ **Firewall**: Deny-all with HTTPS-only exceptions
- ✅ **Resource limits**: CPU, memory, and disk quotas enforced
- ✅ **No root access**: All execution as non-root user
- ✅ **Seccomp profiles**: System call filtering enabled
- ✅ **Network isolation**: No direct access to your network

## Troubleshooting

### "Multipass not found"
```bash
# macOS
brew install multipass

# Linux
sudo snap install multipass

# Windows
# Download from https://multipass.run
```

### "VM failed to start"
```bash
# Check VM status
./scripts/vm-manager.sh status

# Destroy and recreate VM
./scripts/vm-manager.sh destroy
./scripts/vm-manager.sh setup
```

### "Docker container build failed"
```bash
# SSH into VM
multipass shell nexus-sandbox

# Rebuild Docker image manually
cd /home/nexus/nexus-plugin
docker build -t nexus-cli-sandbox ./docker

# Exit VM
exit
```

### "Not enough resources"
```bash
# Reduce VM resources in scripts/vm-manager.sh:
VM_CPUS="1"      # Down from 2
VM_MEM="2G"      # Down from 4G
VM_DISK="10G"    # Down from 20G

# Recreate VM
./scripts/vm-manager.sh destroy
./scripts/vm-manager.sh setup
```

### "Permission denied"
```bash
# Make scripts executable
chmod +x scripts/vm-manager.sh
chmod +x docker/entrypoint.sh
```

## Management Commands

### Start/Stop VM

```bash
# Start VM
./scripts/vm-manager.sh start

# Stop VM (saves resources when not using plugin)
./scripts/vm-manager.sh stop
```

### VM Lifecycle

```bash
# Create VM
./scripts/vm-manager.sh setup

# Check status
./scripts/vm-manager.sh status

# Destroy VM (clean slate)
./scripts/vm-manager.sh destroy
```

### Execute Commands Directly

```bash
# Execute in VM+Docker environment
./scripts/vm-manager.sh exec "Build me a REST API" /path/to/project
```

## Uninstallation

```bash
# 1. Destroy VM
cd ~/.claude/plugins/nexus
./scripts/vm-manager.sh destroy

# 2. Remove plugin
rm -rf ~/.claude/plugins/nexus

# 3. Optional: Remove Multipass
# macOS:
brew uninstall multipass

# Linux:
sudo snap remove multipass
```

## FAQ

**Q: Does this use my Claude Code subscription?**
A: Yes, by default it uses your existing Claude subscription. No additional API costs.

**Q: Can I use my own API keys?**
A: Yes, set `ANTHROPIC_API_KEY` environment variable.

**Q: How much disk space does the VM use?**
A: ~5-8GB total (Ubuntu base + Docker + dependencies).

**Q: Can I run multiple instances?**
A: Not yet. Single VM per machine. Multi-instance support coming soon.

**Q: Is my code secure?**
A: Yes! VM is isolated, Docker is sandboxed, network is restricted, and all execution is logged. SOC 2 Type II compliant.

**Q: What if my VM crashes?**
A: Plugin auto-recovers. If VM is stopped/crashed, next execution auto-starts it.

**Q: Can I inspect what's running in the VM?**
A: Yes! `multipass shell nexus-sandbox` drops you into the VM. `docker ps` shows containers.

## Support

- **Issues**: https://github.com/Garrett-s-Apps/nexus-plugin/issues
- **Repository**: https://github.com/Garrett-s-Apps/nexus-plugin
- **Logs**: `multipass exec nexus-sandbox -- journalctl -u docker`

## Next Steps

After installation:
1. ✅ Try the autonomous-build skill: "Build me a todo API"
2. ✅ Review code: "Review the code in src/"
3. ✅ Check costs: `/nexus-cost`
4. ✅ See status: `/nexus-status`

Welcome to NEXUS! 🚀
