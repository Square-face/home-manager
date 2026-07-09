{
  description = "My Home Manager Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    quickshell.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      quickshell,
      agenix,
      ...
    }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ ];
      };
      extraSpecialArgs = { inherit quickshell; };
    in
    {
      homeConfigurations."sq8@flappy" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs extraSpecialArgs;
        modules = [
          ./modules/default.nix
          ./hosts/flappy.nix
          agenix.homeManagerModules.default
        ];
      };

      homeConfigurations."sq8@shrexbox" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs extraSpecialArgs;
        modules = [
          ./modules/default.nix
          ./hosts/shrexbox.nix
          agenix.homeManagerModules.default
        ];
      };

      homeConfigurations."sq8@frank" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs extraSpecialArgs;
        modules = [
          ./modules/default.nix
          ./hosts/frank.nix
          agenix.homeManagerModules.default
        ];
      };
    };
}
