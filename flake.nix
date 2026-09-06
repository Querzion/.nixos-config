{
  description = "Slisk Lindqvist - NixOS Configuration (thinkpad + desktop)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      mkHost = hostConfig: deModule: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          hostConfig
          deModule
          {
            nix.settings.experimental-features = [ "nix-command" "flakes" ];
          }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.querzion = import ./home/querzion/home.nix;
          }
        ];
      };
    in
    {
      nixosConfigurations = {
        thinkpad-niri   = mkHost ./hosts/thinkpad/configuration.nix ./hosts/thinkpad/desktops/wayland-niri.nix;
        thinkpad-plasma = mkHost ./hosts/thinkpad/configuration.nix ./hosts/thinkpad/desktops/wayland-plasma.nix;
        thinkpad-gnome  = mkHost ./hosts/thinkpad/configuration.nix ./hosts/thinkpad/desktops/wayland-gnome.nix;
        thinkpad-cosmic = mkHost ./hosts/thinkpad/configuration.nix ./hosts/thinkpad/desktops/wayland-cosmic.nix;
        thinkpad-xfce   = mkHost ./hosts/thinkpad/configuration.nix ./hosts/thinkpad/desktops/x11-xfce.nix;

        desktop-niri     = mkHost ./hosts/desktop/configuration.nix ./hosts/desktop/desktops/wayland-niri.nix;
        desktop-plasma   = mkHost ./hosts/desktop/configuration.nix ./hosts/desktop/desktops/wayland-plasma.nix;
        desktop-gnome    = mkHost ./hosts/desktop/configuration.nix ./hosts/desktop/desktops/wayland-gnome.nix;
        desktop-cosmic   = mkHost ./hosts/desktop/configuration.nix ./hosts/desktop/desktops/wayland-cosmic.nix;
        desktop-xfce     = mkHost ./hosts/desktop/configuration.nix ./hosts/desktop/desktops/x11-xfce.nix;
        desktop-hyprland = mkHost ./hosts/desktop/configuration.nix ./hosts/desktop/desktops/wayland-hyprland.nix;
      };
    };
}
