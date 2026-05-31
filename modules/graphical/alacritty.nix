{ config, lib, ... }:
{
  options.alacritty.enable = lib.mkEnableOption "Enable Alacritty";

  config = lib.mkIf config.alacritty.enable {
    programs.alacritty.enable = true;
    programs.alacritty.theme = "catppuccin_mocha";
  };
}
