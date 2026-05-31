{ pkgs, config, ... }:
{
  programs.swaylock.enable = true;
  programs.swaylock.package = pkgs.swaylock-effects;

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

  services.swayidle =
    let
      lock = "${pkgs.swaylock-effects}/bin/swaylock --daemonize";

      undim = "${pkgs.brightnessctl}/bin/brightnessctl set +50%";
      dim = "${pkgs.brightnessctl}/bin/brightnessctl set 50%-";
    in
    {
      enable = true;
      timeouts = [
        {
          timeout = 240; # 4 minutes
          command = dim;
          resumeCommand = undim;
        }
        {
          timeout = 300; # 5 minutes
          command = lock;
        }
      ];
      events = [
        {
          event = "before-sleep";
          command = lock;
        }
        {
          event = "lock";
          command = lock;
        }
      ];
    };
}
