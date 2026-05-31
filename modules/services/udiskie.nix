{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.udiskie.enable = lib.mkEnableOption "Enable udiskie service";
  config = lib.mkIf config.udiskie.enable {
    services.udiskie = {
      enable = true;
      tray = "never";
      settings = {
        program_options = {
          file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
        };
      };
    };
  };
}
