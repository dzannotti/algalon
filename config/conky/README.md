# Conky Configuration

Conky system monitor with Catppuccin Mocha theme.

## Features

- Large clock display
- Weather info for Tallinn, Moscow, and London (via wttr.in)
- Network stats (IP, upload/download speeds)
- CPU usage per core (configured for 24 cores)
- GPU monitoring (NVIDIA)
- Memory and disk usage
- Top processes by CPU, Memory, and I/O

## Network Interface

The config is set to monitor `enp7s0`. You may need to update this to match your network interface:

```bash
# Find your network interface name
ip link show

# Edit the config and replace enp7s0 with your interface name
# Look for lines like: ${addr enp7s0}
```

## Dependencies

- `conky` - System monitor
- `lm_sensors` - For temperature monitoring (CPU/GPU)
- `nvidia-smi` - For NVIDIA GPU stats (part of nvidia drivers)
- `curl` - For weather information

## Weather Locations

Edit `catppuccin-theme/config.conf` lines 88-90 to change weather locations:

```
${texeci 900 curl -s wttr.in/YourCity?format=%l:+%C+%t+%w+%p}
```

## Auto-start

Conky starts automatically via `~/.config/autostart/conky.desktop` after a 3-second delay.

## Manual Start

```bash
bash ~/.config/conky/catppuccin-theme/start.sh
```
