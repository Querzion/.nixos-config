{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.gnome.gcr-ssh-agent.enable = false;

  environment.sessionVariables = {
    XDG_SESSION_TYPE   = "wayland";
    NIXOS_OZONE_WL     = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    wl-clipboard
  ];

  # Remove default GNOME bloat
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    epiphany
    geary
    gnome-weather
    gnome-maps
    gnome-contacts
  ];
}
