#!/usr/bin/env bash

set -Eeuo pipefail

BACKUP="$HOME/desktop-backups/plasma"
CONFIG_BACKUP="$BACKUP/config"
SHARE_BACKUP="$BACKUP/local-share"
STATE_BACKUP="$BACKUP/local-state"

if ! command -v rsync >/dev/null 2>&1; then
    echo "ERROR: rsync is not installed."
    exit 1
fi

# Copy only desktop configuration and user-installed desktop appearance assets.
# --copy-unsafe-links dereferences links pointing outside the source tree
# (for example, Home Manager links into /nix/store) while preserving safe links.
RSYNC_OPTIONS=(
    --archive
    --copy-unsafe-links
    --human-readable
    --info=progress2
    --fsync
    --exclude=Singleton*
    --exclude=*.lock
    --exclude=**/lock
)

backup_item() {
    local source="$1"
    local destination="$2"

    if [[ ! -e "$source" && ! -L "$source" ]]; then
        return 0
    fi

    if [[ -d "$source" && ! -L "$source" ]]; then
        mkdir -p "$destination"
        rsync "${RSYNC_OPTIONS[@]}" "$source/" "$destination/"
    else
        mkdir -p "$(dirname "$destination")"
        rsync "${RSYNC_OPTIONS[@]}" "$source" "$destination"
    fi
}

echo "========================================"
echo "       PLASMA CONFIGURATION BACKUP"
echo "========================================"
echo "Destination: $BACKUP"
echo
mkdir -p "$CONFIG_BACKUP" "$SHARE_BACKUP" "$STATE_BACKUP"

echo "[1/3] Backing up Plasma and desktop settings from ~/.config/"

CONFIG_FILES=(
    kdeglobals
    kwinrc
    kwinrulesrc
    plasmashellrc
    plasma-org.kde.plasma.desktop-appletsrc
    plasmarc
    plasma-localerc
    kglobalshortcutsrc
    kcminputrc
    kscreenlockerrc
    ksmserverrc
    ksplashrc
    kded6rc
    krunnerrc
    breezerc
    gtkrc
)

for file in "${CONFIG_FILES[@]}"; do
    backup_item "$HOME/.config/$file" "$CONFIG_BACKUP/$file"
done

CONFIG_DIRS=(
    fontconfig
    gtk-3.0
    gtk-4.0
)

for directory in "${CONFIG_DIRS[@]}"; do
    backup_item "$HOME/.config/$directory" "$CONFIG_BACKUP/$directory"
done

# GTK 2 theme configuration is stored directly in the home directory.
backup_item "$HOME/.gtkrc-2.0" "$BACKUP/gtkrc-2.0"

echo
echo "[2/3] Backing up desktop appearance assets from ~/.local/share/"

SHARE_DIRS=(
    aurorae
    color-schemes
    fonts
    icons
    themes
    wallpapers
    kwin
)

for directory in "${SHARE_DIRS[@]}"; do
    backup_item \
        "$HOME/.local/share/$directory" \
        "$SHARE_BACKUP/$directory"
done

# Preserve only Plasma-specific appearance and widget resources.
PLASMA_DIRS=(
    desktoptheme
    look-and-feel
    plasmoids
)

for directory in "${PLASMA_DIRS[@]}"; do
    backup_item \
        "$HOME/.local/share/plasma/$directory" \
        "$SHARE_BACKUP/plasma/$directory"
done

echo
echo "[3/3] Backing up desktop-related state from ~/.local/state/"

shopt -s nullglob
STATE_ITEMS=(
    "$HOME"/.local/state/plasma*
    "$HOME"/.local/state/kwin*
    "$HOME"/.local/state/kscreen*
    "$HOME"/.local/state/kactivitymanagerd*
    "$HOME"/.local/state/kglobalaccel*
)
shopt -u nullglob

for source in "${STATE_ITEMS[@]}"; do
    backup_item "$source" "$STATE_BACKUP/$(basename "$source")"
done

echo
echo "========================================"
echo "Flushing filesystem buffers..."
sync

echo
echo "BACKUP COMPLETED SUCCESSFULLY"
echo "Only selected desktop settings and appearance assets were copied."
echo "Location: $BACKUP"
echo "========================================"
