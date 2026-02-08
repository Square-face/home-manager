{pkgs, config, symlinkRoot, quickshell, ...}: let
    inherit (config.lib.file) mkOutOfStoreSymlink;

    toSrcFile = name: "${symlinkRoot}/${name}";
    link = name: mkOutOfStoreSymlink (toSrcFile name);

    linkFile = name: {
        ${name}.source = link name;
    };
    linkDir = name: {
        ${name} = {
            source = link name;
            recursive = true;
        };
    };
in {
    home.packages = [
        pkgs.niri
        pkgs.xwayland-satellite
        pkgs.alacritty
        pkgs.iio-niri
        pkgs.swww
        pkgs.kanshi
        pkgs.brightnessctl
        pkgs.wl-clipboard-rs
    ];

    programs.quickshell.enable = true;
    programs.quickshell.package = quickshell;
    qt.enable = true;
    xdg.configFile = (linkDir "quickshell") // (linkDir "niri");

    systemd.user.services.kanshi = {
    	Unit = {
            Description = "Kanshi Service";
            Requisite = [ "graphical-session.target" ];
            PartOf = [ "graphical-session.target" ];
            After = [ "graphical-session.target" ];
        };
        Install = {
            WantedBy = [ "niri.service" ];
        };
        Service = {
            Type = "simple";
            ExecStart = "${pkgs.kanshi}/bin/kanshi";
            Restart = "on-failure";
        };
    };

    systemd.user.services.awww = {
    	Unit = {
            Description = "Swww Service";
            Requisite = [ "graphical-session.target" ];
            PartOf = [ "graphical-session.target" ];
            After = [ "graphical-session.target" ];
        };
        Install = {
            WantedBy = [ "niri.service" ];
        };
        Service = {
            Type = "simple";
            ExecStart = "${pkgs.swww}/bin/swww-daemon -f argb";
            Restart = "on-failure";
        };
    };

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

    programs.swaylock.enable = true;
    programs.swaylock.package = pkgs.swaylock-effects;

    home.file."${config.xdg.configHome}/kanshi/config".text = ''
        include "${config.xdg.configHome}/kanshi/config.d/*"
    '';

    home.file."${config.xdg.configHome}/swaylock/config".text = ''
        show-failed-attempts
        ignore-empty-password
        screenshots
        clock
        indicator-idle-visible
        indicator-radius=100
        indicator-thickness=7
        ring-color=11111b
        key-hl-color=89dceb
        text-color=cdd6f4
        line-color=f5e0dc00
        inside-color=181825ff
        separator-color=ff000000
        fade-in=0.5
        effect-scale=1
        effect-blur=7x3
        effect-scale=1
        effect-vignette=0.5:0.5
    '';

    services.swayidle = let
        lock = "${pkgs.swaylock-effects}/bin/swaylock --daemonize";
    in {
        enable = true;
        timeouts = [
            {
                timeout = 240; # in seconds
                command = "${pkgs.brightnessctl}/bin/brightnessctl set 50%-";
                resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl set +50%";
            } {
                timeout = 300;
                command = lock;
            }
        ];
        events = [
            {
                event = "before-sleep";
                command = lock;
            } {
                event = "lock";
                command = lock;
            }
        ];
    };

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
