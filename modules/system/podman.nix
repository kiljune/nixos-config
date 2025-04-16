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
  cfg = config.system.podman;
in {
  options.system.podman = {
    enable = mkEnableOption "Enable podman support";
  };

  config = mkIf cfg.enable {
    virtualisation.containers.enable = true;
    virtualisation.libvirtd.enable = true;
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    # Useful other development tools
    environment.systemPackages = with pkgs; [
      dive # look into docker image layers
      podman-tui # status of containers in the terminal
      #docker-compose # start group of containers for dev
      posman-compose # drop-in replacement for docker-compose
    ];
  };
}
