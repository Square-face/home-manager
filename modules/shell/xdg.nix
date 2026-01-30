{ pkgs, ... }:
{
    xdg = {
        enable = true;
        mimeApps.enable = true;
        mimeApps.defaultApplications = {
            "application/pdf" = [ "org.gnome.Evince.desktop" ];
            "x-scheme-handler/discord" = [ "Vesktop.desktop" ];
        };
        portal = {
            enable = true;
            config.niri.default = [
                "gnome"
                "gtk"
                "wlr"
            ];
            config.niri = {
                "org.freedesktop.impl.portal.ScreenCast" = [
                    "gnome"
                ];
                "org.freedesktop.impl.portal.Screenshot" = [
                    "gtk"
                ];
                "org.freedesktop.impl.portal.Inhibit" = [
                    "gtk"
                ];
            };
            extraPortals = with pkgs; [
                xdg-desktop-portal-wlr
                xdg-desktop-portal-gtk
                xdg-desktop-portal-gnome
            ];
        };
    };
}
