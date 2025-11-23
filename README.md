# Algalon

Opinionated Arch Linux home server configuration for media streaming and NAS.

**Status:** 🚧 In active development - forked from [mimiron](https://github.com/dzannotti/mimiron) desktop setup

## What This Is

A repeatable, version-controlled setup that transforms a bare Arch Linux installation into a fully-configured home server focused on:

- **Media Streaming** - Plex/Jellyfin for movies, TV shows, music
- **NAS** - Network-attached storage with SMB/NFS shares
- **Download Management** - Automated media acquisition and organization
- **Remote Access** - Secure access from anywhere
- **Monitoring** - System health, disk usage, service status

## Planned Components

### Media Stack
- [ ] **Plex/Jellyfin** - Media server
- [ ] **Sonarr/Radarr** - TV/Movie automation
- [ ] **Prowlarr** - Indexer management
- [ ] **Transmission/qBittorrent** - Download client
- [ ] **Bazarr** - Subtitle management

### Storage & File Management
- [ ] **Samba** - Windows/macOS network shares
- [ ] **NFS** - Unix/Linux network shares
- [ ] **Cockpit** - Web-based system management
- [ ] **ZFS/BTRFS** - Advanced filesystem with snapshots (TBD)

### System Services
- [ ] **Docker/Podman** - Container runtime for services
- [ ] **Tailscale/WireGuard** - VPN for remote access
- [ ] **Nginx** - Reverse proxy
- [ ] **Fail2ban** - Intrusion prevention
- [ ] **UFW** - Firewall

### Monitoring & Maintenance
- [ ] **Prometheus/Grafana** - Metrics and dashboards
- [ ] **Netdata** - Real-time monitoring
- [ ] **Smartmontools** - Disk health monitoring
- [ ] **Snapper** - Filesystem snapshots

## Installation

### Prerequisites
- Fresh Arch Linux installation
- Base packages installed
- User account created (non-root)
- Working internet connection
- Sufficient storage for media (recommend 4TB+)

### Quick Start

```bash
# Clone to expected location
git clone https://github.com/dzannotti/algalon.git ~/.local/share/algalon

# Run bootstrap (use bash, not source)
bash ~/.local/share/algalon/boot.sh
```

### Post-Install

```bash
# Run post-installation setup
~/.local/share/algalon/first-run.sh
```

### Updating Configuration

```bash
# Pull latest changes and re-apply configuration
algalon-update
```

## Current State (Desktop Remnants)

This repo is currently being transitioned from a GNOME desktop setup to a headless home server. The following desktop-specific components will be removed:

- GNOME desktop environment and extensions
- Desktop applications (VSCode, Chrome, etc.)
- Desktop theming and wallpapers
- GUI-specific keybindings
- Development tools (unless server-relevant)

Core infrastructure being retained:
- Package management approach
- Configuration management patterns
- Update mechanisms
- System hardening (firewall, SSH)
- Snapshot/rollback capability

## Philosophy

- **Headless-first** - No GUI dependencies, web UIs for management
- **Declarative** - Everything in version control
- **Idempotent** - Safe to re-run scripts
- **Minimal** - Only install what's needed
- **Recoverable** - Snapshots for rollback
- **Secure by default** - Firewall, fail2ban, minimal attack surface

## Roadmap

1. **Phase 1** - Remove desktop components, establish headless base
2. **Phase 2** - Add Docker/Podman and container orchestration
3. **Phase 3** - Deploy media stack (Plex + *arr apps)
4. **Phase 4** - Configure storage and network shares
5. **Phase 5** - Add monitoring and alerting
6. **Phase 6** - Remote access and backup strategies

## Notes

Personal home server configuration. Public for my own reference and version control. Not designed as a general-purpose installer, but feel free to steal ideas.

If you came here looking for the desktop setup, see [mimiron](https://github.com/dzannotti/mimiron).
