#!/bin/bash

echo "Configuring Docker..."

# Enable and start Docker service
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo systemctl start docker.service

# Add user to docker group (avoid needing sudo for docker commands)
if ! groups $USER | grep -q docker; then
  sudo usermod -aG docker $USER
  echo "✓ Added $USER to docker group (logout/login required)"
fi

# Create systemd service for homelab stack
echo "Creating homelab stack systemd service..."

sudo tee /etc/systemd/system/algalon-homelab.service >/dev/null <<EOF
[Unit]
Description=Algalon Homelab Docker Stack
Requires=docker.service
After=docker.service network-online.target
Wants=network-online.target

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=$HOME/.local/share/algalon/homelab
ExecStart=/usr/bin/docker-compose up -d
ExecStop=/usr/bin/docker-compose down
TimeoutStartSec=0
User=$USER

[Install]
WantedBy=multi-user.target
EOF

# Enable the homelab service (but don't start it yet - user needs to configure .env first)
sudo systemctl daemon-reload
sudo systemctl enable algalon-homelab.service

echo "✓ Docker configured to start on boot"
echo "✓ Homelab stack service created and enabled"
echo ""
echo "  To start homelab stack: sudo systemctl start algalon-homelab"
echo "  To check status: sudo systemctl status algalon-homelab"
echo "  (Configure ~/.local/share/algalon/homelab/.env first!)"
