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
}:
with lib; let
  cfg = config.system.plymouth;
in {
  options.system.plymouth = {
    enable = mkEnableOption "Enable Plymouth";
  };

  config = mkIf cfg.enable {
    boot = {
      plymouth.enable = true;
      plymouth.theme = "bgrt";
    };

    environment.systemPackages = with pkgs; [
      nixos-bgrt-plymouth
    ];
  };
}
