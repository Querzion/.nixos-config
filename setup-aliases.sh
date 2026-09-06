#!/usr/bin/env bash

BASHRC="$HOME/.bashrc"
MARKER="# === NIXOS ALIASES ==="

# Don't add twice
if grep -q "$MARKER" "$BASHRC"; then
  echo "Aliases already in $BASHRC, skipping."
  exit 0
fi

cat >> "$BASHRC" << 'EOF'

# === NIXOS ALIASES ===
CFG="$HOME/.nixos-config"

# --- Build ---
alias nos-niri='sudo nixos-rebuild switch --flake $CFG#thinkpad-niri'
alias nos-plasma='sudo nixos-rebuild switch --flake $CFG#thinkpad-plasma'
alias nos-gnome='sudo nixos-rebuild switch --flake $CFG#thinkpad-gnome'
alias nos-cosmic='sudo nixos-rebuild switch --flake $CFG#thinkpad-cosmic'
alias nos-xfce='sudo nixos-rebuild switch --flake $CFG#thinkpad-xfce'

alias nos-desktop-niri='sudo nixos-rebuild switch --flake $CFG#desktop-niri'
alias nos-desktop-plasma='sudo nixos-rebuild switch --flake $CFG#desktop-plasma'
alias nos-desktop-gnome='sudo nixos-rebuild switch --flake $CFG#desktop-gnome'
alias nos-desktop-cosmic='sudo nixos-rebuild switch --flake $CFG#desktop-cosmic'
alias nos-desktop-xfce='sudo nixos-rebuild switch --flake $CFG#desktop-xfce'
alias nos-desktop-hyprland='sudo nixos-rebuild switch --flake $CFG#desktop-hyprland'

# --- Update / Upgrade ---
alias nos-update='cd $CFG && nix flake update'
alias nos-upgrade-niri='cd $CFG && nix flake update && sudo nixos-rebuild switch --flake .#thinkpad-niri'
alias nos-upgrade-plasma='cd $CFG && nix flake update && sudo nixos-rebuild switch --flake .#thinkpad-plasma'

# --- Check (dry run) ---
alias nos-check='sudo nixos-rebuild build --flake $CFG#thinkpad-niri'

# --- Home Manager ---
alias hm='cd $CFG && home-manager switch --flake .#querzion'

# --- Git ---
alias gs='git status'
alias ga='git add'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull --rebase'
alias gco='git checkout'
alias lazy='cd $CFG && git add . && git commit -F <(git status -s) && git push'

# --- General ---
alias ll='ls -lah --color=auto'
alias cls='clear'
alias df='df -h'
alias du='du -h'

# === END NIXOS ALIASES ===
EOF

echo "Done. Run 'source ~/.bashrc' to apply."
EOF
