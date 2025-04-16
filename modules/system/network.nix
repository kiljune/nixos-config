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
  # networking
  networking.networkmanager.enable = true;
  networking.hostName = systemSettings.hostname;
  networking.timeServers = options.networking.timeServers.default ++ ["pool.ntp.org"];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
