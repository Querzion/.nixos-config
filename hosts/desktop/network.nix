{ config, pkgs, ... }:

{
  networking.hostName = "desktop";
  networking.networkmanager.enable = true;
}
