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
    frank = {
      id = "XQP7GCA-HAGDVRX-ZPJ3FTW-4GZUGOH-ZLQI3TJ-YL2HTK5-ORKHQB2-VQEXWQU";
      name = "Frank";
      addresses = [
        "quic://10.0.0.1"
        "quic://10.2.2.1"
      ];
    };
  };

  services.syncthing.overrideFolders = true;
  services.syncthing.settings.folders = let
    devices = [
      "frank"
      "flappy"
      "shrexbox"
    ];
  in {
    "~/Desktop" = {
      label = "Desktop";
      id = "desktop";
      inherit devices;
    };
    "~/Documents" = {
      label = "Documents";
      id = "documents";
      inherit devices;
    };
    "~/Pictures" = {
      label = "Pictures";
      id = "pictures";
      inherit devices;
    };
    "~/Music" = {
      label = "Music";
      id = "music";
      inherit devices;
    };
  };
}
