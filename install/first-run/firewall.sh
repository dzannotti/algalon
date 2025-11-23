# Configure UFW firewall for homelab server

echo "Configuring UFW firewall..."

# Default policies
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH (essential - don't lock yourself out!)
sudo ufw allow 22/tcp comment 'SSH'

# Allow Samba (NAS file sharing)
sudo ufw allow 139/tcp comment 'Samba NetBIOS'
sudo ufw allow 445/tcp comment 'Samba SMB'

# Allow NFS (alternative file sharing)
sudo ufw allow 2049/tcp comment 'NFS'

# Allow Tailscale (VPN)
# Tailscale handles its own firewall rules, but allow the interface
sudo ufw allow in on tailscale0

# Turn on the firewall
sudo ufw --force enable

# Enable UFW systemd service to start on boot
sudo systemctl enable ufw

echo "✓ Firewall configured with server rules:"
echo "  - SSH (22)"
echo "  - Samba (139, 445)"
echo "  - NFS (2049)"
echo "  - Tailscale (tailscale0 interface)"
echo
echo "  To add custom rules: sudo ufw allow <port>/<protocol>"
echo "  To check status: sudo ufw status"
