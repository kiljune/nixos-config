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
    ./seahorse.nix
  ];

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = systemSettings.keyboard;
        variant = "";
        options = "caps:escape";
      };
    };
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal
    ];
  };

  environment.systemPackages = with pkgs; [
    polkit_gnome
    gnome-tweaks
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
    gnomeExtensions.app-menu-is-back
    gnomeExtensions.blur-my-shell
    gnomeExtensions.add-to-desktop
    gnomeExtensions.logo-menu
    gnomeExtensions.fuzzy-app-search
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.quick-settings-tweaker
    gnomeExtensions.caffeine
		gnomeExtensions.paperwm
    gnomeExtensions.tiling-shell
    gnomeExtensions.user-themes
  ];
}
