{ config, pkgs, ... }:

{
  services.xserver.enable = false;

  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  programs.kdeconnect.enable = true;

  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    NIXOS_OZONE_WL   = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  environment.systemPackages = with pkgs; [
    kdePackages.kate
    kdePackages.dolphin
    kdePackages.yakuake
    kdePackages.plasma-browser-integration
    wl-clipboard
  ];
}
