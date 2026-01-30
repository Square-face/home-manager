{ pkgs, config, lib, ... }: {
    home.username = "sq8";
    home.homeDirectory = "/home/sq8";
    programs.home-manager.enable = true;

    # Packages installed for the user
    home.packages = with pkgs; [
        usbutils
        xdg-utils

        fastfetch
        btop
        dust

        playerctl
        spotifywm

        nemo-with-extensions

        libreoffice
        evince
        rnote

        vesktop
        thunderbird
        element-desktop
        orca-slicer

        bitwarden-desktop

        # Utils
        fd
        file
        ripgrep

        wget
        nmap
        dig

        libqalculate
        feh
        mpv
    ];

    home.sessionVariables = {
        RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
        CARGO_HOME = "${config.xdg.dataHome}/cargo";
        DOCKER_CONFIG = "${config.xdg.configHome}/docker";
        WINEPREFIX = "${config.xdg.dataHome}/wineprefixes";
    };

    services.udiskie = {
        enable = true;
        tray = "never";
        settings = {
            program_options = {
                file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
            };
        };
    };

    # Home Manager modules to include (these should be proper HM modules)
    imports = [
        modules/shell/gpg.nix
        modules/shell/xdg.nix

        modules/dev/git.nix

        modules/ui/gtk.nix
        modules/default.nix
    ];

    zsh.enable = true;
    zsh.eza.enable = true;
    zsh.tmux.enable = true;
    zsh.direnv.enable = true;
    zsh.starship.enable = true;
    zsh.zoxide.enable = true;

    # Optional: Set Home Manager state version (prevents breakage on updates)
    home.stateVersion = "24.11";

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "spotify"
    ];
}
