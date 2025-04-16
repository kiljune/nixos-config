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
  i18n = {
    inputMethod = {
      type = "kime";
      enable = true;
      kime = {
        daemonModules = [
          "Xim"
          "Wayland"
          "Indicator"
        ];
        iconColor = "White";
        extraConfig = ''
          engine:
            hangul:
              layout: sebeolsik-3-90
        '';
      };
    };
  };
}
