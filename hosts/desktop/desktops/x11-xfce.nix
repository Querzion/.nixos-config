{ config, pkgs, ... }:

{
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  environment.systemPackages = with pkgs; [
    xfce.thunar
    xfce.xfce4-terminal
    wl-clipboard
  ];
}
