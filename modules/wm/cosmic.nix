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
  services = {
    displayManager.cosmic-greeter.enable = true;
    desktopManager.cosmic.enable = true;

    xserver = {
      enable = true;
      xkb = {
        layout = systemSettings.keyboard;
        variant = "";
        options = "caps:escape";
      };
    };
    geoclue2.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-cosmic
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-cosmic
      pkgs.xdg-desktop-portal
    ];
  };

  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;

  environment.systemPackages = with pkgs; [
    cosmic-session
    cosmic-wallpapers
    cosmic-ext-ctl
    cosmic-ext-tweaks
    cosmic-ext-calculator
    polkit_gnome
    caffeine-ng
  ];
}
