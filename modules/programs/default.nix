{ pkgs, lib, ... }:
{

  home.packages = with pkgs; [
    xdg-utils

    fd
    file
    ripgrep

    fastfetch
    btop
    dust
    wget
    nmap
    dig

    libqalculate
  ];
  imports = [
    ./neovim.nix
    ./ssh.nix
    ./zsh.nix
    ./git.nix
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
    ];
}
