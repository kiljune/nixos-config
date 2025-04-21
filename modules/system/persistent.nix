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
}: let
  pShadow = "/persistent/etc/shadow";
  pShadowParent = "/persistent/etc";
in {
  boot.initrd.postResumeCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/root_vg/root /btrfs_tmp
    if [[ -e /btrfs_tmp/@root ]]; then
      delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
          delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
      }

      delete_subvolume_recursively "/btrfs_tmp/@root"
    fi

    btrfs subvolume create /btrfs_tmp/@root
    umount /btrfs_tmp
  '';

  fileSystems."/persistent".neededForBoot = true;
  environment.persistence."/persistent" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/libvirt"
      "/etc/NetworkManager/system-connections"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [
      "/etc/machine-id"
      {
        file = "/var/keys/secret_file";
        parentDirectory = {mode = "u=rwx,g=,o=";};
      }
    ];
  };

  # github.com impermanence Issues Persisting passwords (/etc/shadow) #120
  system.activationScripts = {
    etc_shadow = ''
      [ -f "/etc/shadow" ] && cp /etc/shadow ${pShadow}
      [ -f "${pShadow}" ] && cp ${pShadow} /etc/shadow
    '';

    users.deps = ["etc_shadow"];
  };

  systemd.services."etc_shadow_persistence" = {
    enable = true;
    description = "Persist /etc/shadow on shutdown.";
    wantedBy = ["multi-user.target"];
    path = [pkgs.util-linux];
    unitConfig.defaultDependencies = true;
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      # Service is stopped before shutdown
      ExecStop = pkgs.writeShellScript "persist_etc_shadow" ''
        mkdir --parents "${pShadowParent}"
        cp /etc/shadow ${pShadow}
      '';
    };
  };
}
