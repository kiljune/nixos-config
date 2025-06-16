{pkgs, ...}: let
  python-packages = pkgs.python3.withPackages (
    ps:
      with ps; [
        #requests
        #pyquery # needed for hyprland-dots Weather script
      ]
  );
in {
  environment.systemPackages =
    (with pkgs; [
      wget
      git
      curl
      bat
      stow
      fd
      bc
      jq
      tree
      cpufrequtils
      duf
      fastfetch
      btop
      alejandra
      ffmpeg
      ffmpegthumbnailer
      xdg-user-dirs
      xdg-utils
      cava
      imagemagick
      zip
      unzip
      gum
      rsync
      figlet
      xclip
      wl-clipboard
      cliphist
      power-profiles-daemon
      bluez-tools
      sassc
      appimage-run
      libqalculate
    ])
    ++ [
      python-packages
    ];
}
