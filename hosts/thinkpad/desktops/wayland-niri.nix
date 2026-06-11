{ config, pkgs, ... }:

{
  # Niri: scrollable-tiling Wayland compositor
  programs.niri = {
    enable = true;
  };

  # Display manager
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
    NIXOS_OZONE_WL      = "1";   # Electron/VSCode Wayland
    MOZ_ENABLE_WAYLAND  = "1";   # Firefox
  };

  environment.systemPackages = with pkgs; [
    # Niri essentials
    xwayland-satellite   # XWayland support for legacy apps
    waybar               # status bar
    fuzzel               # app launcher
    mako                 # notifications
    swaylock             # screen lock
    swayidle             # idle management
    wl-clipboard         # clipboard
    grim                 # screenshots
    slurp                # screen region selector
    brightnessctl        # backlight (also in utilities but needed here)

    # Theming
    adwaita-icon-theme
  ];
}
