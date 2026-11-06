{ config, pkgs, ... }:

{
  # PC/SC smart card service
  services.pcscd = {
    enable = true;
    plugins = with pkgs; [
      acsccid
    ];
  };

  # NFC and smart card utilities
  environment.systemPackages = with pkgs; [
    pcsc-tools
    opensc
  ];
}
