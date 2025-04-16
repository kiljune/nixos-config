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
      btrfs subvolume delete /btrfs_tmp/@root/srv
      btrfs subvolume delete /btrfs_tmp/@root/var/lib/portables
      btrfs subvolume delete /btrfs_tmp/@root/var/lib/machines
      btrfs subvolume delete /btrfs_tmp/@root
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

    users.kiljune = {
      directories = [
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Public"
        "Templates"
        "Videos"
        ".config"
        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
        {
          directory = ".local";
          mode = "0700";
        }
        ".librewolf"
        "dotfiles"
        "nixos-config"
        "projects"
      ];
      files = [
        #".screenrc"
        ".bashrc"
        ".profile"
        ".zshrc"
      ];
    };
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
