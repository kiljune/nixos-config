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
    displayManager.ly = {
      enable = true;
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    configPackages = [
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
    kitty
    fuzzel
    polkit_gnome
    waybar
    waypaper
    swaylock
    libnotify
    rofi-wayland
    wlogout
    swappy
    swww
    wallust
    grim
    grimblast
    pinta
    slurp
    loupe
    pavucontrol
    networkmanagerapplet
    swaynotificationcenter
    nautilus
    nautilus-open-any-terminal
    kdePackages.qtstyleplugin-kvantum
    libadwaita
    brightnessctl
  ];
}
