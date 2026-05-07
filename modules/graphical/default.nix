{lib, pkgs, config, ...}: {
  options.graphical.enable = lib.mkEnableOption "Enable graphical modules";

  config = lib.mkIf config.graphical.enable {
    home.packages = with pkgs; [
        virt-manager
        spice-gtk

        usbutils
        spotifywm

        nemo-with-extensions

        evince
        rnote

        vesktop
        fluffychat
        element-desktop
        telegram-desktop
        cinny-desktop

        jellyfin-desktop
        finamp
        orca-slicer

        thunderbird

        feh
        mpv
    ];
  };
}
