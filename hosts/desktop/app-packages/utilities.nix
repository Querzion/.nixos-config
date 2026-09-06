{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # CLI essentials
    curl
    wget
    eza
    unzip
    tree
    nnn
    yazi
    inxi

    # File sharing
    localsend

    # AppImage support
    appimage-run

    # System
    gparted
    udisks2
    polkit
    freerdp

    # Download
    qbittorrent
  ];
}
