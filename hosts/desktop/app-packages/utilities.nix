{ pkgs, ... }:
let
  vuetorrent = pkgs.stdenv.mkDerivation rec {
    pname = "vuetorrent";
    version = "latest-release"; # pin to a specific tag for reproducibility, e.g. "v2.24.0"

    src = pkgs.fetchFromGitHub {
    owner = "VueTorrent";
    repo = "VueTorrent";
    rev = version;
    sha256 = "sha256-UCkqy7ZSPDREYoXXrrEP0K2LaDZQqTcSNbXAPnN2X9k=";
  };

    installPhase = ''
      mkdir -p $out
      cp -r $src/* $out/
    '';
  };
in
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
    vuetorrent
  ];

  # Stable path so qBittorrent's WebUI setting doesn't need to change on rebuilds
  environment.etc."vuetorrent".source = vuetorrent;
}
