{
    description = "My Home Manager Flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        quickshell = {
            url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {nixpkgs, home-manager, quickshell, ...}: {
        homeConfigurations = {
            "sq8" = home-manager.lib.homeManagerConfiguration {
                # System is very important!
                pkgs = import nixpkgs { system = "x86_64-linux"; overlays = []; };

                extraSpecialArgs = {
                    symlinkRoot = "/home/sq8/.config/home-manager/symlinks/";
                    quickshell = quickshell.packages."x86_64-linux".default;
		        };

                modules = [ ./home.nix ]; # Defined later
            };
        };
    };
}
