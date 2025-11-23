# Configure systemd-resolved as DNS resolver
# https://wiki.archlinux.org/title/Systemd-resolved

echo "Configuring systemd-resolved DNS resolver..."

# Tell NetworkManager to use systemd-resolved for DNS
sudo mkdir -p /etc/NetworkManager/conf.d
sudo tee /etc/NetworkManager/conf.d/dns.conf >/dev/null <<'EOF'
[main]
dns=systemd-resolved
EOF

# Enable and start systemd-resolved
sudo systemctl enable systemd-resolved.service
sudo systemctl start systemd-resolved.service

# Symlink resolv.conf to use systemd-resolved
sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

# Restart NetworkManager to pick up the new DNS config
sudo systemctl restart NetworkManager

echo "✓ systemd-resolved configured as DNS resolver"
echo "  To change DNS provider, run: algalon-setup-dns"
