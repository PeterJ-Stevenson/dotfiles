#!/bin/bash
# Bootstrap a fresh CachyOS i3 setup
# Run once after a clean install: bash install.sh
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# ── helpers ──────────────────────────────────────────────────────────────────
info()  { echo "[info]  $*"; }
warn()  { echo "[warn]  $*"; }
die()   { echo "[error] $*" >&2; exit 1; }

link() {
    local src="$1" dst="$2"
    mkdir -p "$(dirname "$dst")"
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        warn "Backing up existing $dst → $dst.bak"
        mv "$dst" "$dst.bak"
    fi
    ln -sfn "$src" "$dst"
    info "linked $dst → $src"
}

need_cmd() { command -v "$1" &>/dev/null || die "$1 not found. Install it first."; }

# ── package install ───────────────────────────────────────────────────────────
install_packages() {
    info "Installing core packages..."
    sudo pacman -S --needed --noconfirm \
        i3-wm \
        i3status \
        py3status \
        picom \
        dunst \
        rofi \
        feh \
        terminator \
        flameshot \
        brightnessctl \
        xss-lock \
        xorg-xset \
        xorg-xrdb \
        xorg-xrandr \
        xdotool \
        xsel \
        numlockx \
        network-manager-applet \
        blueman \
        pavucontrol \
        pamixer \
        playerctl \
        imagemagick \
        keychain \
        keepassxc \
        autorandr \
        lxappearance \
        qt5ct \
        qt6ct \
        polkit-gnome \
        xdg-user-dirs \
        fzf \
        zoxide \
        direnv \
        mpg123 \
        conky \
        firefox \
        nemo \
        kubectl

    info "Installing AUR packages (requires yay or paru)..."
    if command -v yay &>/dev/null; then
        AUR=yay
    elif command -v paru &>/dev/null; then
        AUR=paru
    else
        warn "No AUR helper found. Install yay or paru, then run:"
        warn "  $AUR -S --needed oh-my-posh-bin spotify pa-applet-git obsidian"
        warn "  # and whatever work apps you need: slack-desktop teams-for-linux-bin etc."
        return
    fi

    $AUR -S --needed --noconfirm \
        oh-my-posh-bin \
        spotify \
        pa-applet-git \
        pwvucontrol \
        obsidian \
        code-insiders \
        xautolock

    info "Optional work apps (uncomment what you use):"
    info "  $AUR -S slack-desktop teams-for-linux-bin outlook-for-linux mattermost-desktop"
    info "  $AUR -S forticlient awsvpnclient"
    info "  $AUR -S assume-bin  # Granted AWS credential manager"
}

# ── dotfile links ─────────────────────────────────────────────────────────────
install_dotfiles() {
    info "Linking dotfiles..."

    link "$DOTFILES/config/i3/config"        "$HOME/.config/i3/config"
    link "$DOTFILES/config/i3/i3status.conf" "$HOME/.config/i3/i3status.conf"
    link "$DOTFILES/config/dunst/dunstrc"    "$HOME/.config/dunst/dunstrc"
    link "$DOTFILES/config/picom.conf"       "$HOME/.config/picom.conf"
    link "$DOTFILES/Xresources"              "$HOME/.Xresources"
    link "$DOTFILES/config/terminator/config" "$HOME/.config/terminator/config"

    link "$DOTFILES/screenlayout/laptop.sh"  "$HOME/.screenlayout/laptop.sh"
    link "$DOTFILES/screenlayout/office.sh"  "$HOME/.screenlayout/office.sh"
    link "$DOTFILES/screenlayout/home.sh"    "$HOME/.screenlayout/home.sh"

    for f in updateWallpaper.sh blackOut.sh stayOn.sh typeclipboard.sh i3exit lock lightdm-random-bg.sh; do
        link "$DOTFILES/bin/$f" "$HOME/bin/$f"
        chmod +x "$DOTFILES/bin/$f"
    done

    info "NOTE: lightdm-random-bg.sh also needs a systemd unit at /etc/systemd/system/lightdm-random-bg.service"
    info "      See README or run: sudo systemctl enable lightdm-random-bg.service"

    # Make sure ~/bin is in PATH (check your .bashrc)
    if ! echo "$PATH" | grep -q "$HOME/bin"; then
        warn "~/bin is not in your PATH. Add this to ~/.bashrc:"
        warn '  export PATH="$HOME/bin:$PATH"'
    fi
}

# ── post-install notes ────────────────────────────────────────────────────────
post_install_notes() {
    info ""
    info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    info "Done. A few things to do manually:"
    info ""
    info "1. Wallpaper: put images in ~/pics/backgrounds/"
    info ""
    info "2. Screen layouts: run 'xrandr --query' to find your output names,"
    info "   then update ~/.screenlayout/home.sh (the office/laptop ones may"
    info "   also need output names adjusted for the new hardware)."
    info ""
    info "3. Lock screen: the lock script uses imagemagick to blur a screenshot."
    info "   Test it with: ~/bin/lock"
    info ""
    info "4. .bashrc: copy yours from the old machine and scrub any secrets."
    info "   (API tokens, GITHUB_TOKEN, etc. do NOT belong in the file.)"
    info "   Use a secrets manager or load them from a file outside the repo."
    info ""
    info "5. SSH keys: copy ~/.ssh from the old machine (or generate new ones)."
    info ""
    info "6. py3status / conky: the i3status bar uses conky for memory/disk/load."
    info "   Make sure conky is installed and py3status can find it."
    info ""
    info "7. Spotify: no --audio-api flag needed on CachyOS (pipewire-pulse handles it)."
    info ""
    info "8. GTK/Qt themes: run lxappearance (GTK) and qt6ct (Qt) to set a consistent theme."
    info "   Set QT_QPA_PLATFORMTHEME=qt6ct in your .bashrc so Qt apps pick it up."
    info ""
    info "9. autorandr: after setting up your screen layouts, save them:"
    info "   autorandr --save home"
    info "   autorandr --save office"
    info "   autorandr --save laptop"
    info "   Then 'autorandr --change' auto-applies the right one on plug/unplug."
    info "   Add 'exec --no-startup-id autorandr --change' to i3 config if wanted."
    info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# ── main ──────────────────────────────────────────────────────────────────────
case "${1:-all}" in
    packages)   install_packages ;;
    dotfiles)   install_dotfiles ;;
    notes)      post_install_notes ;;
    all)
        install_packages
        install_dotfiles
        post_install_notes
        ;;
    *)
        echo "Usage: $0 [all|packages|dotfiles|notes]"
        exit 1
        ;;
esac
