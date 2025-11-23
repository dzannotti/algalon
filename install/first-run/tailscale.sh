# Configure and start Tailscale VPN

if ! command -v tailscale &> /dev/null; then
    echo "⚠ Tailscale not installed, skipping"
    return 0
fi

echo "Configuring Tailscale..."

# Enable and start tailscaled service
sudo systemctl enable tailscaled.service
sudo systemctl start tailscaled.service

# Bring up Tailscale
# --accept-routes: accept subnet routes advertised by other nodes
# --ssh: enable Tailscale SSH (alternative to port 22)
echo "Starting Tailscale (this will open a browser for auth)..."
sudo tailscale up --accept-routes --ssh

echo "✓ Tailscale configured and running"
echo "  To check status: tailscale status"
echo "  To get IP: tailscale ip -4"
