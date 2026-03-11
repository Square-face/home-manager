{
    description = "My Home Manager Flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
        quickshell.inputs.nixpkgs.follows = "nixpkgs";

        awww.url = "git+https://codeberg.org/LGFae/awww";
        awww.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs@{nixpkgs, home-manager, quickshell, awww, ...}: {
        homeConfigurations = {
            "sq8" = home-manager.lib.homeManagerConfiguration {
                # System is very important!
                pkgs = import nixpkgs { system = "x86_64-linux"; overlays = []; };

                extraSpecialArgs = {
                    quickshell = quickshell;
                    awww = awww;
		        };

                modules = [ ./home.nix ]; # Defined later
            };
        };
    };
}
