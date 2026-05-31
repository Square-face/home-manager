{
  config,
  lib,
  pkgs,
  symlinkRoot,
  ...
}:
{
  options = {
    zsh.enable = lib.mkEnableOption "Enable ZSH";
    zsh.starship.enable = lib.mkEnableOption "Enable Starship";
    zsh.direnv.enable = lib.mkEnableOption "Enable Direnv";
    zsh.eza.enable = lib.mkEnableOption "Enable Eza";
    zsh.tmux.enable = lib.mkEnableOption "Enable Tmux";
    zsh.fzf.enable = lib.mkEnableOption "Enable FzF";
    zsh.highlighting.enable = lib.mkEnableOption "Enable Syntax Highlighting";
    gpg.enable = lib.mkEnableOption "Enable GPG";
  };

  config =
    let
      cfg = config.zsh;

      gpg = lib.mkIf config.gpg.enable {
        programs.gpg = {
          enable = true;
          homedir = "${config.xdg.dataHome}/gnupg";
          settings = {
            use-agent = true;
          };
        };

        services.gpg-agent = {
          enable = true;
          defaultCacheTtl = 1800;
          enableSshSupport = true;
          enableExtraSocket = true;
          pinentry.package = pkgs.pinentry-qt;

        };
      };

      starship = lib.mkIf cfg.starship.enable {
        programs.starship.enable = true;
        xdg.configFile."starship.toml".source =
          config.lib.file.mkOutOfStoreSymlink "${symlinkRoot}/starship.toml";
      };

      direnv = lib.mkIf cfg.direnv.enable {
        programs.direnv = {
          enable = true;
          nix-direnv.enable = true;
          enableZshIntegration = true;
        };
      };

      eza = lib.mkIf cfg.eza.enable {
        programs.eza = {
          enable = true;
          icons = "never";
          git = true;
          enableZshIntegration = true;
          extraOptions = [
            "--group-directories-first"
          ];
        };
      };

      tmux = lib.mkIf cfg.tmux.enable {
        programs.tmux = {
          enable = true;
          keyMode = "vi";
          baseIndex = 1;
          plugins = with pkgs; [
            {
              plugin = tmuxPlugins.catppuccin;
              extraConfig = ''
                set -g @catppuccin_flavor 'mocha' # latte, frappe, macchiato or mocha
                set -g @catppuccin_window_status_style "rounded"
                set -g @catppuccin_window_text " #W"
                set -g @catppuccin_window_current_style "rounded"
                set -g @catppuccin_window_current_text " #W"

                set -g status-right-length 100
                set -g status-left-length 100
                set -g status-left ""
                set -g status-right "#{E:#H}"
                set -ag status-right "#{E:@catppuccin_status_uptime}"
              '';
            }
          ];
          extraConfig = ''
            set -g status-interval 0
            set -s escape-time 0
          '';
        };
      };

      zsh = lib.mkIf cfg.enable {
        programs.zsh = {
          enable = true;
          enableVteIntegration = true;
          defaultKeymap = "emacs";
          shellAliases = {
            v = "${pkgs.neovim}/bin/nvim";
            zdev = "nix develop --command zsh";

            g = "git";

            wget = "wget --hsts-file=\"\$XDG_CACHE_HOME/wget-hsts\"";

            tmpcd = "cd $(mktemp -d)";
          };
          initContent = ''
            bindkey "^[[1;3C" forward-word
            bindkey "^[[1;3D" backward-word
            nixz() { nix-shell -p "$@" --run 'env SHELL=zsh zsh' }
          '';
          dotDir = "${config.xdg.configHome}/zsh";
          historySubstringSearch.enable = true;
          history = {
            path = "${config.xdg.dataHome}/zsh/zsh_history";
          };
          syntaxHighlighting = lib.mkIf cfg.highlighting.enable {
            enable = true;
            highlighters = [ "brackets" ];
          };
        };
      };

      fzf = lib.mkIf cfg.fzf.enable {
        programs.fzf.enable = true;
        programs.fzf.enableZshIntegration = true;
      };

    in
    lib.mkMerge [
      gpg
      zsh
      starship
      eza
      tmux
      direnv
      fzf
    ];
}
