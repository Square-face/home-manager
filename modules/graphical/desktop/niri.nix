{
  pkgs,
  quickshell,
  linkDir,
  ...
}:
{
  home.packages = [
    pkgs.niri
    pkgs.xwayland-satellite
    pkgs.wl-clipboard-rs
    pkgs.wdisplays
  ];

  programs.quickshell.enable = true;
  programs.quickshell.package = quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
  qt.enable = true;

  xdg.configFile = linkDir "quickshell" // linkDir "niri";

  systemd.user.services.iio-niri = {
    Unit = {
      Description = "IIO-Niri";
      Requisite = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "niri.service" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.iio-niri}/bin/iio-niri --monitor eDP-1";
      Restart = "on-failure";
    };
  };
}
