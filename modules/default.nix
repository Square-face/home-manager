{ ... }:
{
  imports = [
    ./graphical/default.nix
    ./graphical/firefox.nix
    ./graphical/alacritty.nix

    ./graphical/desktop/default.nix

    ./programs/default.nix

    ./services/udiskie.nix
  ];
}
