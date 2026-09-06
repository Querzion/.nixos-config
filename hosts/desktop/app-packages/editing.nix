{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gimp
    libreoffice
    figma-linux
    #inkscape
    #krita
  ];
}
