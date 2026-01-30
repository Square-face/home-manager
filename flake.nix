{
    description = "My Home Manager Flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
	ewwii.url = "github:Ewwii-sh/ewwii";
    };

    outputs = {nixpkgs, home-manager, ewwii, ...}: {
        homeConfigurations = {
            "sq8" = home-manager.lib.homeManagerConfiguration {
                # System is very important!
                pkgs = import nixpkgs { system = "x86_64-linux"; overlays = [ ewwii.overlays.default ]; };
		extraSpecialArgs = {
		  symlinkRoot = "${builtins.toString ./.}/symlinks/";
		};

                modules = [ ./home.nix ]; # Defined later
            };
        };
    };
}
