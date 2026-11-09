{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    keepassxc
    libsecret

    # YubiKey management
    yubikey-manager
    yubioath-flutter
    yubikey-touch-detector
    yubikey-personalization
  ];

  # YubiKey udev rules
  services.udev.packages = [
    pkgs.yubikey-personalization
  ];

  security.rtkit.enable = true;
}
