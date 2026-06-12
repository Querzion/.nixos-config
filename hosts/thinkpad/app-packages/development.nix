{ config, pkgs, ... }:

let
  dotnetSdks = with pkgs.dotnetCorePackages;
    combinePackages [ sdk_8_0 sdk_9_0 sdk_10_0 ];
in
{
  environment.systemPackages = with pkgs; [
    jetbrains.rider
    jetbrains.rust-rover
    jetbrains.webstorm
    vscode

    dotnetSdks

    rustup

    nodejs
    npm-check

    python3
    python3Packages.pip

    git
    gh
    lazygit

    gnumake
    gcc

    postman
    insomnia

    docker
    docker-compose
  ];

  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_10_0}";
  };

  environment.variables.PATH = [
    "${pkgs.dotnetCorePackages.sdk_10_0}/bin"
    "${pkgs.dotnetCorePackages.sdk_9_0}/bin"
    "${pkgs.dotnetCorePackages.sdk_8_0}/bin"
  ];

  virtualisation.docker.enable = true;
}
