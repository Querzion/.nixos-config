{ pkgs, ... }:

{
  # Steam (also pulls in the FHS runtime needed for most games)
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # CPU/GPU performance-on-demand daemon used by Steam, Heroic, Lutris, etc.
  programs.gamemode.enable = true;

  # 32-bit graphics drivers — required for Wine/Steam 32-bit binaries
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    heroic              # Epic/GOG/Amazon launcher
    faugus-launcher     # lightweight launcher for Windows games via UMU/Proton
    protonplus          # manages Proton-GE/Wine/DXVK/VKD3D builds across launchers
    mangohud            # FPS/frametime/temps overlay — wrap a launch command with `mangohud`, or configure via GOverlay
    goverlay            # GUI for configuring MangoHud presets
    wineWow64Packages.stable  # Wine with both 64-bit and 32-bit support
    winetricks
    lutris
  ];
}
