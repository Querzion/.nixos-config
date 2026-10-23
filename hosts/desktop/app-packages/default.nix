{ config, pkgs, ... }:

{
  imports = [
    ./audio.nix
    ./communication.nix
    ./development.nix
    ./editing.nix
    ./gaming.nix
    ./security.nix
    ./utilities.nix
    ./video.nix
  ];
}
