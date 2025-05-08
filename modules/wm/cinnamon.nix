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
  ];

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = systemSettings.keyboard;
        variant = "";
        options = "caps:escape";
      };
      displayManager = {
        lightdm.enable = true;
        sessionCommands = ''
          xset -dpms
          xset s blank
          xset r rate 350 50
          xset s 300
          ${pkgs.lightlocker}/bin/light-locker --idle-hint &
        '';
      };
      desktopManager.cinnamon.enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
  };

  environment.systemPackages = with pkgs; [
    polkit_gnome
    caffeine-ng
  ];
}
