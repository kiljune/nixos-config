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
  imports = [
    ./cliUtils.nix
    ./guiApps.nix
    ./gtkQt.nix
    ./development.nix
    ./nvim.nix
  ];

  programs = {
    #steam = {
    #  enable = true;
    #  gamescopeSession.enable = true;
    #  remotePlay.openFirewall = true;
    #  dedicatedServer.openFirewall = true;
    #};

    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
