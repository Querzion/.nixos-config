{ config, pkgs, ... }:

{
  programs.niri.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri-session";
        user = "greeter";
      };
    };
  };

  environment.sessionVariables = {
    XDG_SESSION_TYPE    = "wayland";
    XDG_CURRENT_DESKTOP = "niri";
    NIXOS_OZONE_WL      = "1";
    MOZ_ENABLE_WAYLAND  = "1";
  };

  environment.systemPackages = with pkgs; [
    alacritty
    fuzzel
    waybar
    swaybg
    mako
    libnotify
    grim
    slurp
    swaylock
    swayidle
    xwayland-satellite
    wl-clipboard
    adwaita-icon-theme
    papirus-icon-theme
    gtk3
    dconf
    gsettings-desktop-schemas
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
