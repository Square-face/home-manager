{
  pkgs,
  config,
  lib,
  linkDir,
  ...
}:
let
  grammars = with pkgs.vimPlugins.nvim-treesitter-parsers; [
    lua
    nix
    zsh
    terraform
  ];

  rtdir = lib.mkAfter (
    builtins.concatStringsSep "\n" (
      builtins.map (g: "vim.o.runtimepath = vim.o.runtimepath .. ',${g}'") grammars
    )
  );

  options = lib.mkBefore ''
    vim.g.mapleader = " "

    vim.o.number = true
    vim.o.relativenumber = true

    vim.o.swapfile = false

    -- Resonable tabs, fight me
    vim.o.tabstop = 4
    vim.o.shiftwidth = 4
    vim.o.expandtab = true
    vim.o.smartindent = true

    vim.o.winborder = "rounded"
    vim.o.completeopt = 'fuzzy,menuone,noselect,popup'
  '';
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    withPython3 = false;
    withRuby = false;
    initLua = lib.mkMerge [
      rtdir
      options
    ];
  };
}
