{config, ...}: {
  services.syncthing = {
    enable = true;
    cert = config.age.secrets.syncthing-cert.path;
    key = config.age.secrets.syncthing-key.path;
  };
  services.syncthing.settings.options.urAccepted = -1;

  services.syncthing.overrideDevices = true;
  services.syncthing.settings.devices = {
    shrexbox = {
      id = "4KR27ZF-KFKKONT-FPNS3HS-22R3KAP-M7YDUSX-DN44NZM-53DMNRP-22RQDAK";
      name = "Shrexbox";
      addresses = [
        "quic://10.0.0.153"
        "quic://10.2.100.1"
      ];
    };
    flappy = {
      id = "IOIUI2K-R4PREEK-73IPJIX-B4SM5WU-MONRZ3L-RTRJXFX-O6JCGNS-LN32MAK";
      name = "Flappy";
      addresses = [
        "quic://10.0.0.152"
        "quic://10.2.100.4"
      ];
    };
  };

  services.syncthing.overrideFolders = true;
  services.syncthing.settings.folders = {
    "~/Desktop" = {
      label = "Desktop";
      id = "desktop";
      devices = [
        "flappy"
        "shrexbox"
      ];
    };
    "~/Documents" = {
      label = "Documents";
      id = "documents";
      devices = [
        "flappy"
        "shrexbox"
      ];
    };
    "~/Pictures" = {
      label = "Pictures";
      id = "pictures";
      devices = [
        "flappy"
        "shrexbox"
      ];
    };
    "~/Music" = {
      label = "Music";
      id = "music";
      devices = [
        "flappy"
        "shrexbox"
      ];
    };
  };
}
