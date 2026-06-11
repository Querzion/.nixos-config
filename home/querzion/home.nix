{ pkgs, ... }:

{
  imports = [
    ./bashrc.nix
    ./git.nix
  ];

  programs.starship.enable = true;
  programs.fastfetch.enable = true;

  home.packages = with pkgs; [
    btop
    eza
  ];

  home.stateVersion = "25.05";
}
