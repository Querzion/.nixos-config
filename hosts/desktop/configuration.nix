{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./bluetooth.nix
    ./locale.nix
    ./network.nix
    ./services.nix
    ./users.nix
    ./fonts.nix
    ./virtualization.nix
    ./app-packages
  ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05";
}
