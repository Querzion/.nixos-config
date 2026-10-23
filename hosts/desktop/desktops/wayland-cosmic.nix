{ config, pkgs, ... }:

{
  services.xserver.enable = false;

  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  environment.sessionVariables = {
    XDG_SESSION_TYPE            = "wayland";
    COSMIC_DATA_CONTROL_ENABLED = 1;
    NIXOS_OZONE_WL              = "1";
    MOZ_ENABLE_WAYLAND          = "1";
  };

  services.geoclue2.enable = true;

  environment.systemPackages = with pkgs; [
    libsecret
    wl-clipboard
  ];
}
