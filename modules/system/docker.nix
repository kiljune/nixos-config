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
  cfg = config.system.docker;
in {
  options.system.docker = {
    enable = mkEnableOption "Enable docker support";
  };

  config = mkIf cfg.enable {
    virtualisation.containers.enable = true;
    virtualisation.libvirtd.enable = true;
    users.users."${userSettings.username}".extraGroups = ["docker"];
    virtualisation.docker = {
      enable = true;
    };

    # Useful other development tools
    environment.systemPackages = with pkgs; [
      dive # look into docker image layers
      docker-compose # start group of containers for dev
    ];
  };
}
