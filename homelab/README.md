# Algalon Homelab Stack

Complete media server, NAS, and automation setup using Docker.

## Stack Overview

**Media Streaming:**
- Jellyfin - Media server
- Jellyseerr - Request management

**Media Management:**
- Sonarr - TV shows
- Radarr - Movies
- Lidarr - Music
- Bazarr - Subtitles
- Prowlarr - Indexer management

**Download Clients:**
- qBittorrent - Torrents (through VPN)
- NZBGet - Usenet (through VPN)

**Infrastructure:**
- Gluetun - VPN (ExpressVPN)
- Pi-hole - Ad blocking + local DNS
- Caddy - Reverse proxy
- Samba - NAS file shares
- Syncthing - File synchronization
- ntfy - Notifications

## Prerequisites

1. **Algalon server installed** with base setup complete
2. **Tailscale configured** on host (done by first-run.sh)
3. **Docker and docker-compose** installed (done by install.sh)

## Initial Setup

### 1. Create Data Directory Structure

```bash
sudo mkdir -p /data/{media/{movies,tv,music},downloads/{complete,incomplete},sync,private,public}
sudo chown -R $USER:$USER /data
```

### 2. Configure Environment Variables

```bash
cd ~/.local/share/algalon/homelab
cp .env.example .env
nano .env
```

Fill in:
- Your user PUID/PGID (run `id $USER`)
- ExpressVPN credentials
- Pi-hole admin password
- Samba password

### 3. Configure UFW Firewall

Allow necessary ports for homelab services:

```bash
# DNS (Pi-hole)
sudo ufw allow 53/tcp comment 'DNS'
sudo ufw allow 53/udp comment 'DNS'

# HTTP/HTTPS (Caddy reverse proxy)
sudo ufw allow 80/tcp comment 'HTTP'
sudo ufw allow 443/tcp comment 'HTTPS'
sudo ufw allow 443/udp comment 'HTTP/3'

# Samba (already allowed by first-run.sh)
# sudo ufw allow 139/tcp comment 'Samba'
# sudo ufw allow 445/tcp comment 'Samba'

# Syncthing (if accessing from other devices)
sudo ufw allow 22000/tcp comment 'Syncthing'
sudo ufw allow 22000/udp comment 'Syncthing'
sudo ufw allow 21027/udp comment 'Syncthing Discovery'

# Jellyfin (if you want direct access, otherwise use reverse proxy)
sudo ufw allow 8096/tcp comment 'Jellyfin'

# Reload firewall
sudo ufw reload
sudo ufw status numbered
```

### 4. Start the Stack

```bash
cd ~/.local/share/algalon/homelab
docker-compose up -d
```

### 5. Configure Pi-hole DNS

#### On Pi-hole:
1. Access Pi-hole at `http://algalon-ip:8082/admin`
2. Login with password from .env
3. Go to **Local DNS > DNS Records**
4. Add A record: `algalon.com` → `algalon-ip` (e.g., 192.168.1.54)
5. Pi-hole will automatically resolve `*.algalon.com` via Caddy

#### On Your Router:
1. Set primary DNS to algalon IP (e.g., 192.168.1.54)
2. Set secondary DNS to 1.1.1.1 (Cloudflare) as fallback
3. Save and reboot router if needed

### 6. Access Services

After DNS is configured:

- **Jellyfin**: http://jellyfin.algalon.com
- **Jellyseerr**: http://jellyseerr.algalon.com
- **Radarr**: http://radarr.algalon.com
- **Sonarr**: http://sonarr.algalon.com
- **Lidarr**: http://lidarr.algalon.com
- **Bazarr**: http://bazarr.algalon.com
- **qBittorrent**: http://qbittorrent.algalon.com
- **Prowlarr**: http://prowlarr.algalon.com
- **Pi-hole**: http://pihole.algalon.com
- **Syncthing**: http://syncthing.algalon.com
- **ntfy**: http://ntfy.algalon.com

Or via direct IP:port before DNS is set up (see docker-compose.yml for ports).

## Post-Setup Configuration

### Jellyfin

1. Complete initial setup wizard
2. Add media libraries:
   - Movies: `/media/movies`
   - TV Shows: `/media/tv`
   - Music: `/media/music`

### Prowlarr

1. Add indexers
2. Connect to Sonarr, Radarr, Lidarr (use internal IPs: 172.39.0.x)

### Sonarr/Radarr/Lidarr

1. Connect to Prowlarr for indexers
2. Add download clients:
   - qBittorrent: `gluetun:8080` (uses VPN container)
   - NZBGet: `gluetun:6789`
3. Configure paths:
   - Downloads: `/data/downloads`
   - Media: `/data/media/{movies|tv|music}`

### Jellyseerr

1. Connect to Jellyfin (use `http://172.39.0.10:8096`)
2. Connect to Sonarr/Radarr (use internal IPs)
3. Configure user permissions

### Samba

Access from any device on your network:
- Windows: `\\algalon-ip\media`
- Mac: `smb://algalon-ip/media`
- Linux: `smb://algalon-ip/media`

Shares:
- `media` - Read-only media library
- `downloads` - Download folder
- `private` - Private storage (user auth required)
- `public` - Public share (no auth)

## Maintenance

### Update Containers

```bash
cd ~/.local/share/algalon/homelab
docker-compose pull
docker-compose up -d
```

### View Logs

```bash
docker-compose logs -f [service-name]
```

### Restart Services

```bash
docker-compose restart [service-name]
```

### Stop Everything

```bash
docker-compose down
```

## Troubleshooting

### VPN not working

Check Gluetun logs:
```bash
docker logs gluetun
```

Verify IP is VPN:
```bash
docker exec qbittorrent curl ifconfig.me
```

### DNS not resolving

1. Check Pi-hole is running: `docker ps | grep pihole`
2. Test DNS: `nslookup jellyfin.algalon.com algalon-ip`
3. Check router DNS settings point to algalon

### Can't access services

1. Check UFW: `sudo ufw status`
2. Check containers: `docker ps -a`
3. Check Caddy config: `docker exec caddy caddy validate --config /etc/caddy/Caddyfile`

## Data Directory Structure

```
/data/
├── media/
│   ├── movies/      # Radarr managed
│   ├── tv/          # Sonarr managed
│   └── music/       # Lidarr managed
├── downloads/
│   ├── complete/    # Finished downloads
│   └── incomplete/  # In-progress downloads
├── sync/            # Syncthing folder
├── private/         # Private Samba share
└── public/          # Public Samba share
```

## Notes

- **Tailscale** runs on host (not in docker) for better network integration
- **VPN kill switch** - if Gluetun goes down, download clients stop
- **Deunhealth** auto-restarts qBittorrent if VPN connection drops
- All containers restart automatically unless stopped manually
