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
  cfg = config.system.virt-manager;
in {
  options.system.virt-manager = {
    enable = mkEnableOption "Enable podman support";
  };

  config = mkIf cfg.enable {
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = ["${userSettings.username}"];
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu.runAsRoot = false;
        allowedBridges = [
          "nm-bridge"
          "virbr0"
        ];
      };
      spiceUSBRedirection.enable = true;
    };
  };
}
