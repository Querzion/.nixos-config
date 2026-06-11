{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./battery.nix
    ./bluetooth.nix
    ./locale.nix
    ./network.nix
    ./services.nix
    ./users.nix
    ./fonts.nix
    ./app-packages
  ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
