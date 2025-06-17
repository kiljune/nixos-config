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
    displayManager.sddm = {
      enable = true;
      theme = "chili";
    };
    xserver = {
      enable = false;
      xkb = {
        layout = systemSettings.keyboard;
        variant = "";
        options = "caps:escape";
      };
      excludePackages = [pkgs.xterm];
    };
  };

  programs = {
    niri = {
      enable = true;
      package = pkgs.niri;
    };
  };

  environment.systemPackages = with pkgs; [
    polkit_gnome
    waybar
    waypaper
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
