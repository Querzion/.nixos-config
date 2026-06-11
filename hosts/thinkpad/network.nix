{ config, pkgs, ... }:

{
  networking.hostName = "thinkpad";
  networking.networkmanager.enable = true;
}
