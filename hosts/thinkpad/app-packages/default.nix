{ config, pkgs, ... }:

{
  imports = [
    ./audio.nix
    ./communication.nix
    ./development.nix
    ./editing.nix
    ./utilities.nix
    ./video.nix
    ./security.nix
  ];
}
