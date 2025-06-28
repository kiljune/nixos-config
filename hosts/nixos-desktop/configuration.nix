# Main default config
{
  config,
  pkgs,
  options,
  lib,
  inputs,
  system,
  systemSettings,
  userSettings,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./users.nix
    ../../modules/system/system.nix
    ../../modules/packages/packages.nix
    ../../modules/system/persistent.nix
    (./. + "../../../modules/wm" + ("/" + userSettings.wm) + ".nix")
    (./. + "../../../modules/system/gpu" + ("/" + systemSettings.gpu) + ".nix")
  ];

  # mount Backup disk
  fileSystems."/mnt/Backup" = {
    device = "/dev/disk/by-uuid/68d28b8f-aa8e-4463-96dc-407e3e877d15";
    fsType = "ext4";
  };

  # Extra Module Options
  local.hardware-clock.enable = false;
  system.plymouth.enable = false;
  system.powermanagement.enable = false;
  system.btrfs.enable = false;
  system.zfs.enable = false;
  system.zram.enable = true;
  system.podman.enable = true;
  system.docker.enable = false;
  system.virt-manager.enable = true;

  nixpkgs.config.allowUnfree = true;
  users = {
    mutableUsers = true;
  };

  console.keyMap = systemSettings.keyboard;

  # For Electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  system.stateVersion = "25.05";
}
