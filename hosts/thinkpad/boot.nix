{ config, pkgs, ... }:

{
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    plymouth.enable = true;
    plymouth.theme = "bgrt";

    kernelParams = [
      "quiet"
      "splash"
    ];

    kernelPackages = pkgs.linuxPackages_latest;

    kernelModules = [
      "hid_magicmouse"
      "hid_apple"
    ];

    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };
  };
}
