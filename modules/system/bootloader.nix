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
  boot = {
    ## BOOT LOADERS: NOTE USE ONLY 1. either systemd or grub
    # Bootloader SystemD
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi = {
        #efiSysMountPoint = "/efi"; #this is if you have separate /efi partition
        canTouchEfiVariables = true;
      };
      timeout = 3;
    };
    ## -end of BOOTLOADERS----- ##

    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
  };
}
