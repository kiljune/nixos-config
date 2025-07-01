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
  # Services to start
  services = {
    smartd = {
      enable = false;
      autodetect = true;
    };

    gvfs.enable = true;
    tumbler.enable = true;

    udev.enable = true;
    envfs.enable = true;

    fstrim = {
      enable = true;
      interval = "weekly";
    };

    libinput.enable = true;

    rpcbind.enable = false;
    nfs.server.enable = false;

    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        UsePAM = false;
      };
    };

    gnome.gnome-keyring.enable = true;

    blueman.enable = true;

    cron = {
      enable = true;
      systemCronJobs = [
        #"00 9 * * 1 echo 'Hello'"
      ];
    };

    fwupd.enable = true;

    #hardware.openrgb.enable = true;
    #hardware.openrgb.motherboard = "amd";

    #printing = {
    #  enable = false;
    #  drivers = [
    # pkgs.hplipWithPlugin
    #  ];
    #};

    #avahi = {
    #  enable = true;
    #  nssmdns4 = true;
    #  openFirewall = true;
    #};

    #ipp-usb.enable = true;
  };
}
