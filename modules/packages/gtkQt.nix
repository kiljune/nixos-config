{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gtk3
    gtk4
    gtk-engine-murrine
    papirus-folders
    papirus-icon-theme
    nordzy-icon-theme
    bibata-cursors
    nordic
    orchis-theme
    whitesur-gtk-theme
    whitesur-kde
    libsForQt5.qt5ct
    libsForQt5.qt5.qtwayland
    qt6ct
    qt6.qtwayland
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2
    kdePackages.breeze
    kdePackages.qtsvg
  ];
}
