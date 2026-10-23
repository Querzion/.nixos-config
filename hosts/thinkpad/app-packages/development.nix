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

  # Install .NET templates for the real user, at *activation* time — not as a
  # build-time derivation like before. `dotnet new install` needs to reach
  # NuGet, and Nix build sandboxes have no network access, so that could
  # never succeed as a derivation on a machine that doesn't already have it
  # cached (this only ever "worked" here because it was cached from before
  # sandboxing caught up with it — the exact same thing broke on a fresh
  # desktop build). Activation scripts run on the live, already-built system
  # (with real network), so this is the correct place for it. Templates land
  # in querzion's own ~/.templateengine, not "system-wide" (dotnet templates
  # are always per-user, regardless of who runs the install).
  system.activationScripts.dotnet-templates = {
    text = ''
      echo "Ensuring .NET templates are installed for querzion..."
      ${pkgs.util-linux}/bin/runuser -l querzion -c '
        export PATH="${dotnetSdks}/bin:$PATH"
        dotnet new install "Umbraco.Templates" || true
        dotnet new install "Avalonia.Templates" || true
        dotnet new install "DotVVM.Templates" || true
        dotnet new install "Popov1024.HttpApi.Template.CSharp" || true
        dotnet new install "Robell.AksApi.Template" || true
        dotnet new install "GatewayProgrammingSchool.xUnit.CSharp" || true
        dotnet new install "eisk.webapi" || true
      ' || true
    '';
    deps = [ "users" ];
  };

  ####################
  # Environment Vars #
  ####################
  environment.sessionVariables = {
    # Point at the *combined* SDK derivation, not a single version — this is
    # what makes `dotnet --list-sdks` show 8/9/10 together.
    DOTNET_ROOT = "${dotnetSdks}";
    # NOTE: deliberately NOT setting sessionVariables.PATH here. Those
    # entries get prepended ahead of everything else, including dotnetSdks
    # itself (already on PATH via environment.systemPackages) — so it was
    # shadowing the combined multi-SDK dotnet with a single, standalone
    # SDK's own binary every time.
  };

  environment.variables.PATH = [
    "${pkgs.dotnetCorePackages.sdk_10_0}/bin"
    "${pkgs.dotnetCorePackages.sdk_9_0}/bin"
    "${pkgs.dotnetCorePackages.sdk_8_0}/bin"
  ];

  virtualisation.docker.enable = true;
}
