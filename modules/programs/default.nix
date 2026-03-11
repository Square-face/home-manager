{pkgs, lib, ...}: {
    home.packages = with pkgs; [
        virt-manager
        spice-gtk

        telegram-desktop
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
        fluffychat
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

    imports = [
        ./alacritty.nix
        ./firefox.nix
        ./neovim.nix
        ./rofi.nix
        ./dunst.nix
        ./ssh.nix
    ];

    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "spotify"
    ];
}
