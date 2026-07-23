{ pkgs, inputs, ... }:

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
    #inputs.superfile.packages.${pkgs.system}.default
    superfile
  ];

  home.stateVersion = "25.05";
}
