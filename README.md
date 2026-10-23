# NixOS Configuration (thinkpad + desktop)

Flake-based NixOS config covering two machines, each supporting multiple
desktop environments.

## Structure

```
.nixos-config/
├── flake.nix
├── hosts/
│   ├── thinkpad/
│   │   ├── configuration.nix      # top-level imports
│   │   ├── hardware-configuration.nix  # generated on install
│   │   ├── boot.nix
│   │   ├── battery.nix            # TLP + auto-cpufreq
│   │   ├── bluetooth.nix
│   │   ├── locale.nix
│   │   ├── network.nix
│   │   ├── services.nix
│   │   ├── users.nix
│   │   ├── fonts.nix
│   │   ├── app-packages/
│   │   │   ├── default.nix
│   │   │   ├── audio.nix
│   │   │   ├── communication.nix
│   │   │   ├── development.nix
│   │   │   ├── editing.nix
│   │   │   ├── utilities.nix
│   │   │   ├── video.nix
│   │   │   └── security.nix
│   │   └── desktops/
│   │       ├── wayland-niri.nix   ← primary target
│   │       ├── wayland-plasma.nix ← fallback
│   │       ├── wayland-gnome.nix
│   │       ├── wayland-cosmic.nix
│   │       └── x11-xfce.nix
│   └── desktop/
│       ├── configuration.nix      # top-level imports
│       ├── hardware-configuration.nix  # PLACEHOLDER — generate on the actual machine
│       ├── boot.nix
│       ├── bluetooth.nix
│       ├── locale.nix
│       ├── network.nix            # hostname = "desktop"
│       ├── services.nix
│       ├── users.nix
│       ├── fonts.nix
│       ├── app-packages/
│       │   ├── default.nix
│       │   ├── audio.nix
│       │   ├── communication.nix
│       │   ├── development.nix
│       │   ├── editing.nix
│       │   ├── gaming.nix          # Steam, GameMode, Heroic, Faugus, ProtonPlus
│       │   ├── security.nix
│       │   ├── utilities.nix
│       │   └── video.nix
│       └── desktops/
│           ├── wayland-plasma.nix
│           ├── wayland-niri.nix
│           ├── wayland-hyprland.nix
│           ├── wayland-gnome.nix
│           ├── wayland-cosmic.nix
│           └── x11-xfce.nix
└── home/
    └── querzion/
        ├── home.nix
        ├── bashrc.nix
        └── git.nix
```

`locale.nix` and `fonts.nix` are intentionally duplicated per host rather than
shared, matching the existing thinkpad pattern. `desktop`'s app-packages carry
everything from `thinkpad` (audio, communication, development, editing,
security, utilities, video) minus laptop-only bits (battery/backlight tools),
plus a `gaming.nix` module — the ThinkPad is a clean dev-only install, the
desktop is dev + gaming.

## Installation (desktop)

1. Boot NixOS ISO, partition and mount drives
2. Generate hardware config:
   ```bash
   sudo nixos-generate-config --root /mnt
   ```
3. Clone this repo:
   ```bash
   git clone https://github.com/Querzion/.nixos-config ~/.nixos-config
   ```
4. Copy the generated hardware config over the placeholder:
   ```bash
   cp /mnt/etc/nixos/hardware-configuration.nix ~/.nixos-config/hosts/desktop/
   ```
5. First build:
   ```bash
   sudo nixos-rebuild switch --flake ~/.nixos-config#desktop-plasma
   ```

## Switching desktops

```bash
# thinkpad
nos-niri
nos-plasma
nos-gnome
nos-cosmic
nos-xfce

# desktop
nos-desktop-niri
nos-desktop-plasma
nos-desktop-gnome
nos-desktop-cosmic
nos-desktop-xfce
nos-desktop-hyprland

nos-update  # update flake inputs
```
