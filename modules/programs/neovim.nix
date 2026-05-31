{
  pkgs,
  config,
  linkDir,
  ...
}:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    withPython3 = false;
    withRuby = false;
  };

  xdg.configFile.nvim.source = ../../symlinks/nvim;
  xdg.configFile.nvim.recursive = true;
}
