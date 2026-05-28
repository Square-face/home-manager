{pkgs, ...}: {
  home.packages = [
    pkgs.awww
  ];
  systemd.user.services.awww = {
    Unit = {
      Description = "Awww Service";
      Requisite = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "niri.service" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.awww}/bin/awww-daemon -f argb";
      Restart = "on-failure";
    };
  };
}
