{ config, pkgs, ... }:
let
  # Combine the two SDKs into a single derivation that contains both.
  # `combinePackages` already puts every `bin/` directory on $PATH.
  dotnetSdks = with pkgs.dotnetCorePackages;
    combinePackages [ sdk_8_0 sdk_9_0 sdk_10_0 ];
  # Run the template installations at activation time.
  # The script is executed as root, but `dotnet` will write the templates
  # into the system-wide store, so they are available to every user.
  installTemplates = pkgs.runCommandLocal "install-dotnet-templates" {
    buildInputs = [ dotnetSdks ];
  } ''
    mkdir -p $out
    dotnet new install "Umbraco.Templates"
    dotnet new install "Avalonia.Templates"
    dotnet new install "DotVVM.Templates"
    dotnet new install "Popov1024.HttpApi.Template.CSharp"
    dotnet new install "Robell.AksApi.Template"
    dotnet new install "GatewayProgrammingSchool.xUnit.CSharp"
    dotnet new install "eisk.webapi"
    echo "All .NET templates installed!" > $out/log
  '';
in
{
  ####################
  # System Packages  #
  ####################
  environment.systemPackages = with pkgs; [
    # Editors & IDEs
    jetbrains.rider
    jetbrains.rust-rover
    jetbrains.webstorm
    vscode

    # .NET
    dotnetSdks

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

  # Install the templates when the system is activated.
  system.activationScripts.dotnet-templates = {
    text = ''
      echo "Ensuring .NET templates are installed..."
      ${installTemplates}
    '';
    deps = [ "etc" ];
  };

  ####################
  # Environment Vars #
  ####################
  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_10_0}";
    PATH = [
      "${pkgs.dotnetCorePackages.sdk_10_0}/bin"
      "${pkgs.dotnetCorePackages.sdk_9_0}/bin"
      "${pkgs.dotnetCorePackages.sdk_8_0}/bin"
    ];
  };

  # Docker daemon
  virtualisation.docker.enable = true;
}
