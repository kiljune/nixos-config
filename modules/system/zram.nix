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
  cfg = config.system.zram;
in {
  options.system.zram = {
    enable = mkEnableOption "Enable zramSwap Modules";
  };

  config = mkIf cfg.enable {
    zramSwap = {
      enable = true;
      priority = 130;
      memoryPercent = 25;
      swapDevices = 1;
      algorithm = "zstd";
    };
  };
}
