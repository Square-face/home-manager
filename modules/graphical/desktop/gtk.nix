{ pkgs, config, ... }: {
    home.packages = with pkgs; [

        # Fonts
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        font-awesome
        source-han-sans
        source-han-serif
        nerd-fonts.fira-code
        dconf

        bibata-cursors
        magnetic-catppuccin-gtk
    ];


    fonts = {
        fontconfig = {
            enable = true;
            defaultFonts = {
                serif = [
                "Noto Serif"
                "Source Han Serif"
                ];
                sansSerif = [
                "Noto Sans"
                "Source Han Sans"
                ];
            };
        };
    };

    home.pointerCursor = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
    };

    gtk = {
        enable = true;
        colorScheme = "dark";

        theme.name = "Catppuccin-GTK-Dark";
        theme.package = pkgs.magnetic-catppuccin-gtk;

        cursorTheme.name = "Bibata-Modern-Classic";
        cursorTheme.package = pkgs.pkgs.bibata-cursors;

        iconTheme.name = "Papirus-Dark";
        iconTheme.package = pkgs.papirus-icon-theme;

        gtk4.theme = config.gtk.theme;
        gtk4.iconTheme = config.gtk.iconTheme;
        gtk4.cursorTheme = config.gtk.cursorTheme;

        gtk3.theme = config.gtk.theme;
        gtk3.iconTheme = config.gtk.iconTheme;
        gtk3.cursorTheme = config.gtk.cursorTheme;

        gtk2.theme = config.gtk.theme;
        gtk2.iconTheme = config.gtk.iconTheme;
        gtk2.cursorTheme = config.gtk.cursorTheme;
    };
}
