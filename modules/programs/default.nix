{pkgs, ...}: {
    home.packages = with pkgs; [
        virt-manager
        spice-gtk
    ];

    imports = [
        ./alacritty.nix
        ./firefox.nix
        ./neovim.nix
        ./rofi.nix
        ./dunst.nix
    ];
}
