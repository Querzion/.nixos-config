{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  environment.sessionVariables = {
    XDG_SESSION_TYPE    = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    NIXOS_OZONE_WL      = "1";
    MOZ_ENABLE_WAYLAND  = "1";
  };

  environment.systemPackages = with pkgs; [
    hyprpaper
    hypridle
    hyprlock
    waybar
    wofi
    mako
    libnotify
    grim
    slurp
    wl-clipboard
    adwaita-icon-theme
    papirus-icon-theme
    gtk3
    dconf
    gsettings-desktop-schemas
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
  };
}
