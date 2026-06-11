{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Editors & IDEs
    jetbrains.rider
    jetbrains.rust-rover
    jetbrains.webstorm
    vscode

    # .NET (installed via Nix, dotnet-ef via alias in bashrc)
    dotnet-sdk_8

    # Rust
    rustup

    # Node
    nodejs
    npm-check

    # Python
    python3
    python3Packages.pip

    # Git
    git
    gh
    lazygit

    # Build tools
    gnumake
    gcc

    # API tools
    postman
    insomnia

    # Docker
    docker
    docker-compose
  ];

  # Docker daemon
  virtualisation.docker.enable = true;
}
