# NixOS ThinkPad Configuration

Flake-based NixOS config for ThinkPad T14s, supporting multiple desktop environments.

## Structure

```
.nixos-config/
├── flake.nix
├── hosts/
│   └── thinkpad/
│       ├── configuration.nix      # top-level imports
│       ├── hardware-configuration.nix  # generated on install
│       ├── boot.nix
│       ├── battery.nix            # TLP + auto-cpufreq
│       ├── bluetooth.nix
│       ├── locale.nix
│       ├── network.nix
│       ├── services.nix
│       ├── users.nix
│       ├── fonts.nix
│       ├── app-packages/
│       │   ├── default.nix
│       │   ├── audio.nix
│       │   ├── communication.nix
│       │   ├── development.nix
│       │   ├── editing.nix
│       │   ├── utilities.nix
│       │   ├── video.nix
│       │   └── security.nix
│       └── desktops/
│           ├── wayland-niri.nix   ← primary target
│           ├── wayland-plasma.nix ← fallback
│           ├── wayland-gnome.nix
│           ├── wayland-cosmic.nix
│           └── x11-xfce.nix
└── home/
    └── slisk/
        ├── home.nix
        ├── bashrc.nix
        └── git.nix
```

## Installation

1. Boot NixOS ISO, partition and mount drives
2. Generate hardware config:
   ```bash
   nixos-generate-config --root /mnt
   ```
3. Clone this repo:
   ```bash
   git clone https://github.com/Querzion/.nixos-config ~/.nixos-config
   ```
4. Copy generated hardware config:
   ```bash
   cp /mnt/etc/nixos/hardware-configuration.nix ~/.nixos-config/hosts/thinkpad/
   ```
5. First build (start with plasma for easiest setup):
   ```bash
   sudo nixos-rebuild switch --flake ~/.nixos-config#thinkpad-plasma
   ```

## Switching desktops

```bash
nos-niri    # switch to Niri
nos-plasma  # switch to Plasma
nos-gnome   # switch to GNOME
nos-cosmic  # switch to COSMIC
nos-xfce    # switch to XFCE
nos-update  # update flake inputs
```
