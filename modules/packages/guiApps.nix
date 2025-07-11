{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (mpv.override {scripts = [mpvScripts.mpris];})
    kitty
    ptyxis
    librewolf
    neovide
    keepassxc
  ];
}
