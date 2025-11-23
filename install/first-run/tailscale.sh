# Configure and start Tailscale VPN

if ! command -v tailscale &> /dev/null; then
    echo "⚠ Tailscale not installed, skipping"
    return 0
fi

echo "Configuring Tailscale..."

# Enable and start tailscaled service
sudo systemctl enable tailscaled.service
sudo systemctl start tailscaled.service

# Check if already authenticated
if sudo tailscale status &>/dev/null; then
    echo "✓ Tailscale already configured"
else
    echo "⚠ Tailscale needs authentication"
    echo ""
    echo "  Headless server setup requires an auth key:"
    echo "  1. Visit: https://login.tailscale.com/admin/settings/keys"
    echo "  2. Generate an auth key (check 'Reusable' and set expiry)"
    echo "  3. Run: sudo tailscale up --authkey=tskey-auth-xxx --accept-routes --ssh"
    echo ""
    echo "  Or authenticate from another device:"
    echo "  1. Run: sudo tailscale up --accept-routes --ssh"
    echo "  2. Copy the URL and open it on a device with a browser"
    echo ""
fi

echo "  To check status: tailscale status"
echo "  To get IP: tailscale ip -4"
