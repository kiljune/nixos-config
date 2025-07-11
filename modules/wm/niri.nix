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
    displayManager.sddm = {
      enable = true;
      theme = "chili";
      wayland.enable = true;
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
    sddm-chili-theme
    nautilus
    nautilus-open-any-terminal
    nwg-look
    nwg-displays
    nwg-dock-hyprland
    kdePackages.qtstyleplugin-kvantum
    xfce.tumbler
    libadwaita
    brightnessctl
  ];
}
