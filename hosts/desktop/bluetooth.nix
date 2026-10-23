{ config, pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        UserspaceHID = true;
        MaxConnections = 10;
      };
    };
  };

  services.upower.enable = true;
}
