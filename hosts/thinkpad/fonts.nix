{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-mono
    nerd-fonts.jetbrains-mono
    corefonts
    google-fonts
  ];
}
