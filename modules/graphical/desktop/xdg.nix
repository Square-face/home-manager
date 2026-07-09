{ pkgs, ... }:
{
  xdg = {
    configHome = "/home/sq8/.config";
    enable = true;
    mimeApps.enable = true;
    mimeApps.defaultApplications = {
      "application/pdf" = [ "org.gnome.Evince.desktop" ];
      "x-scheme-handler/discord" = [ "Vesktop.desktop" ];
    };
  };
}
