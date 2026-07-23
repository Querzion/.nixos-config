{
  description = "Slisk Lindqvist - ThinkPad NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    superfile.url = "github:yorukot/superfile";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      mkHost = desktop: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/thinkpad/configuration.nix
          desktop
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.querzion = import ./home/querzion/home.nix;
          }
        ];
      };
    in
    {
      nixosConfigurations = {
        thinkpad-niri   = mkHost ./hosts/thinkpad/desktops/wayland-niri.nix;
        thinkpad-plasma = mkHost ./hosts/thinkpad/desktops/wayland-plasma.nix;
        thinkpad-gnome  = mkHost ./hosts/thinkpad/desktops/wayland-gnome.nix;
        thinkpad-cosmic = mkHost ./hosts/thinkpad/desktops/wayland-cosmic.nix;
        thinkpad-xfce   = mkHost ./hosts/thinkpad/desktops/x11-xfce.nix;
      };
    };
}
