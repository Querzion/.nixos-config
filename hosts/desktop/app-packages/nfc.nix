{ config, pkgs, ... }:

{
  services.pcscd = {
    enable = true;
    plugins = with pkgs; [
      acsccid
    ];
  };

  #services.udev.extraRules = ''
  #  # ACS ACR1252U-M1 NFC Reader
  #  SUBSYSTEM=="usb", ATTR{idVendor}=="072f", ATTR{idProduct}=="223b", MODE="0660", GROUP="pcscd", TAG+="uaccess"
  #'';

  environment.systemPackages = with pkgs; [
    pcsc-tools
    opensc
  ];
}
