{ config, pkgs, ... }:

{
  networking.hostName = "thinkpad";
  networking.networkmanager.enable = true;

  networking.networkmanager.insertNameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];
}
