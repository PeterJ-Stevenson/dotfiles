# dotfiles

i3 setup for CachyOS (Arch-based). Migrated from Manjaro.

## What's included

| Path | Description |
|------|-------------|
| `config/i3/config` | i3 window manager config |
| `config/i3/i3status.conf` | py3status bar (Spotify, net, memory, battery, clock) |
| `config/dunst/dunstrc` | Notification daemon |
| `config/picom.conf` | Compositor (GLX, shadows, vsync) |
| `config/terminator/config` | Terminal — JetBrains Mono, transparent, Shift+↓ new tab |
| `screenlayout/laptop.sh` | Single screen (undocked) |
| `screenlayout/office.sh` | Triple monitor docked (office) |
| `screenlayout/home.sh` | Triple monitor docked (home) — **update output names** |
| `bin/lock` | Blurred screenshot lock (imagemagick + i3lock) |
| `bin/i3exit` | Session actions: lock/suspend/hibernate/reboot/shutdown |
| `bin/updateWallpaper.sh` | Random wallpaper from `~/pics/backgrounds/` via feh |
| `bin/blackOut.sh` | Immediately blank all screens |
| `bin/stayOn.sh` | Disable DPMS / screensaver |
| `bin/typeclipboard.sh` | Type clipboard contents via xdotool |
| `Xresources` | Font rendering, cursor size, terminal colors |

## Install

```bash
git clone git@github.com:YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash install.sh
```

Runs in three steps: installs packages (pacman + AUR), symlinks configs, prints post-install notes.

You can also run steps individually:

```bash
bash install.sh packages   # pacman/AUR only
bash install.sh dotfiles   # symlinks only
bash install.sh notes      # print the checklist
```

## Key bindings (i3)

| Binding | Action |
|---------|--------|
| `Mod+Return` | Terminal (terminator) |
| `Mod+d` | App launcher (rofi) |
| `Mod+q` | System mode (lock/suspend/reboot/shutdown) |
| `Mod+F12` | Lock screen |
| `Mod+Ctrl+k` | Toggle KeePassXC scratchpad |
| `Mod+Ctrl+s` | Toggle Spotify scratchpad |
| `Mod+Ctrl+a` | Toggle AWS VPN scratchpad |
| `Mod+Ctrl+p` | Toggle FortiClient scratchpad |
| `Mod+Ctrl+b` | Toggle Nemo scratchpad |
| `Mod+Ctrl+F10/11/12` | Screen layout: home / office / laptop |
| `Mod+F8 / F9` | Keyboard layout: GB / DK |
| `Mod+F1` | Type clipboard via xdotool |
| `Print` | Screenshot (flameshot) |
| `Alt+1–0` | Move workspace to specific monitor |

## Terminator

| Binding | Action |
|---------|--------|
| `Shift+↓` | New tab |
| `Shift+→` | Next tab |
| `Shift+←` | Previous tab |

## After install

1. **Wallpapers** — put images in `~/pics/backgrounds/`
2. **Screen layouts** — run `xrandr --query` to get output names, update `~/.screenlayout/home.sh` (and check the others fit new hardware)
3. **SSH keys** — copy `~/.ssh` from old machine or generate new ones
4. **`.bashrc`** — copy from old machine, but strip any hardcoded secrets before committing
5. **Work apps** — Slack, Teams, Outlook, Mattermost, FortiClient, AWS VPN are not auto-installed; see commented lines in `install.sh`

## Dependencies

Core (pacman): `i3-wm i3lock py3status picom dunst rofi feh terminator flameshot brightnessctl xss-lock xautolock imagemagick keychain keepassxc fzf zoxide direnv conky`

AUR: `oh-my-posh-bin spotify pa-applet-git obsidian code-insiders`
