{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (mpv.override {scripts = [mpvScripts.mpris];})
    kitty
    keepassxc
    neovide
  ];
}
