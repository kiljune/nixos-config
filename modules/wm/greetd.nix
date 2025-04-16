{
  pkgs,
  config,
  options,
  lib,
  inputs,
  system,
  systemSettings,
  userSettings,
  ...
}: {
  environment.systemPackages = with pkgs; [
    greetd.tuigreet
  ];

  services.greetd = {
    enable = true;
    vt = 7;
    settings = {
      default_session = {
        user = userSettings.username;
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --remember-session --time --cmd Hyprland";
      };
    };
  };

  programs.uwsm.enable = true;
  programs.uwsm.waylandCompositors = {
    hyprland = {
      prettyName = "Hyprland-UWSM";
      comment = "Hyprland compositor manager by UWSM";
      binPath = "/run/current-system/sw/bin/Hyprland";
    };
  };
}
