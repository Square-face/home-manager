{
  description = "My Home Manager Flake";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    quickshell.inputs.nixpkgs.follows = "nixpkgs";
    
    awww.url = "git+https://codeberg.org/LGFae/awww";
    awww.inputs.nixpkgs.follows = "nixpkgs";
  };
  
  outputs = inputs@{nixpkgs, home-manager, quickshell, awww, ...}: {
    homeConfigurations."sq8@flappy" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { system = "x86_64-linux"; overlays = []; };
      extraSpecialArgs = { inherit quickshell awww; };

      modules = [
      ./modules/default.nix

      ./flappy.nix 
      ];
    };
  };
}
