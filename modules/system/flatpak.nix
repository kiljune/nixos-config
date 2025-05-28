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
  imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

  services = {
    flatpak = {
      enable = true;
      packages = [
        "com.github.tchx84.Flatseal"
        "org.mozilla.firefox"
        "org.keepassxc.KeePassXC"
        #"com.calibre_ebook.calibre"
        #"org.getoutline.OutlineClient"
      ];
    };
  };

  systemd.services.flatpak-repo = {
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
