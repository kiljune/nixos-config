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
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    configPackages = [
      pkgs.xdg-desktop-portal-gnome
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
