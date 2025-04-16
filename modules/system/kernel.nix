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
    #kernelPackages = pkgs.linuxPackages_zen; # zen Kernel
    kernelPackages = pkgs.linuxPackages_latest; # Kernel
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.mask=systemd-vconsole-setup.service"
      "systemd.mask=dev-tpmrm0.device" #this is to mask that stupid 1.5 mins systemd bug
      "nowatchdog"
      #"modprobe.blacklist=sp5100_tco" #watchdog for AMD
      "modprobe.blacklist=iTCO_wdt" #watchdog for Intel
    ];

    # This is for OBS Virtual Cam Support
    #kernelModules = [ "v4l2loopback" ];
    #extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

    # Needed For Some Steam Games
    #kernel.sysctl = {
    #  "vm.max_map_count" = 2147483642;
    #};
  };
}
