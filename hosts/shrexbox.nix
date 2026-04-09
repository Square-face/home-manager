{ pkgs, config, lib, ... }: let 
  inherit (config.lib.file) mkOutOfStoreSymlink;

  symlinkRoot = "/home/sq8/.home/symlinks/";
  toSrcFile = name: "${symlinkRoot}${name}";
  link = name: mkOutOfStoreSymlink (toSrcFile name);

  linkFile = name: { "${name}".source = link name; };
  linkDir  = name: { "${name}" = { source = link name; recursive = true; }; };
in {
  _module.args = {
    inherit link linkFile linkDir symlinkRoot;
  };

  home.username = "sq8";
  home.homeDirectory = "/home/sq8";
  programs.home-manager.enable = true;

  home.sessionVariables = {
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    DOCKER_CONFIG = "${config.xdg.configHome}/docker";
    WINEPREFIX = "${config.xdg.dataHome}/wineprefixes";
  };

  graphical.enable = true;

  alacritty.enable = true;

  zsh.enable = true;
  zsh.fzf.enable = true;
  zsh.highlighting.enable = true;
  zsh.eza.enable = true;
  zsh.tmux.enable = true;
  zsh.direnv.enable = true;
  zsh.starship.enable = true;
  gpg.enable = true;

  udiskie.enable = true;


  programs.lutris.enable = true;
  programs.lutris.steamPackage = pkgs.steam;
  programs.lutris.winePackages = [ pkgs.wineWow64Packages.full ];

  # Optional: Set Home Manager state version (prevents breakage on updates)
  home.stateVersion = "24.11";
}
