{ pkgs, config, linkDir, ... }: {
    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        defaultEditor = true;
    };

    xdg.configFile.nvim.source = ../../symlinks/nvim;
    xdg.configFile.nvim.recursive = true;
}
