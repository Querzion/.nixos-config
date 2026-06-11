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

    # Laptop extras
    acpi          # battery/ACPI info
    brightnessctl # backlight control
  ];
}
