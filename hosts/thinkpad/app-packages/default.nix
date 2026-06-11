{ config, pkgs, ... }:

{
  imports = [
    ./app-packages/audio.nix
    ./app-packages/communication.nix
    ./app-packages/development.nix
    ./app-packages/editing.nix
    ./app-packages/utilities.nix
    ./app-packages/video.nix
    ./app-packages/security.nix
  ];
}
