# GDM Configuration Files

This directory contains configuration files for styling the GDM (GNOME Display Manager) login screen.

## Current Configuration

The GDM configuration focuses on what's reliably achievable without complex theme hacking:

**Configured settings:**
- **Color Scheme:** Dark mode with purple accent (Catppuccin Mocha colors)
- **Background:** shaded.png (from default/backgrounds)
- **Primary Color:** #1e1e2e (Catppuccin Mocha base)

**Not configured (requires additional work):**
- GTK Theme (requires system-wide installation and GDM CSS customization)
- Logo (Catppuccin logo is too large at 1544x1544px)
- Icons/Cursor (GDM doesn't always respect these in user themes)

## Files

### `gdm-dconf`
Contains the dconf settings for GDM's appearance. This file is deployed to `/etc/dconf/db/gdm.d/01-algalon` and compiled into GDM's dconf database.

### `gdm-profile`
Defines the dconf profile for GDM, specifying where GDM should look for its settings database. This is deployed to `/etc/dconf/profile/gdm`.

## How It Works

1. During `first-run.sh`, the configuration files are copied to system locations:
   - `gdm-dconf` → `/etc/dconf/db/gdm.d/01-algalon`
   - `gdm-profile` → `/etc/dconf/profile/gdm`

2. The shaded background wallpaper is copied to `/usr/share/backgrounds/algalon/`

3. The Catppuccin logo is copied to `/usr/share/pixmaps/`

4. `dconf update` compiles the text configuration into a binary database that GDM reads

5. GDM directories are created with proper permissions for the `gdm` user

## Testing Changes

After modifying these files, you can test them by running:

```bash
# Copy updated files
sudo cp ~/.local/share/algalon/default/gnome/gdm-dconf /etc/dconf/db/gdm.d/01-algalon
sudo cp ~/.local/share/algalon/default/gnome/gdm-profile /etc/dconf/profile/gdm

# Recompile dconf database
sudo dconf update

# Restart GDM to see changes
sudo systemctl restart gdm
```

**Warning:** Restarting GDM will log you out!

## Customization

To customize the GDM theme:

1. Edit `gdm-dconf` with your desired settings
2. Run the installation via `first-run.sh` or manually copy and compile
3. Restart GDM

