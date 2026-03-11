{pkgs, config, ...}: {
  home.file."${config.xdg.configHome}/kanshi/config".text = ''
    include "${config.xdg.configHome}/kanshi/config.d/*"
  '';

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
}
