{pkgs, ...}: {
    home.packages = with pkgs; [
        virt-manager
        spice-gtk
    ];

    imports = [
        ./firefox.nix
        ./neovim.nix
        ./rofi.nix
        ./dunst.nix
    ];
}
