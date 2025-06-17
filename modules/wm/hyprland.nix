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

  security.pam.services.hyprlock = {
    text = ''auth include login '';
  };

  services = {
    displayManager.sddm = {
      enable = true;
      theme = "chili";
      wayland.enable = true;
    };
  };

  programs = {
    hyprland = {
      enable = true;
      package = pkgs.hyprland;
      xwayland = {
        enable = true;
      };
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };

  programs.uwsm.enable = true;
  programs.uwsm.waylandCompositors = {
    hyprland = {
      prettyName = "hyprland UWSM";
      comment = "Hyperland compositor manager by UWSM";
      binPath = "/run/current-system/sw/bin/hyprland";
    };
  };

  environment.systemPackages = with pkgs; [
    polkit_gnome
    hypridle
    hyprlock
    hyprpaper
    hyprpicker
    hyprshade
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
