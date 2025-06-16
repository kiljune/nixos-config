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
        "it.mijorus.gearlever"
        "io.github.flattool.Warehouse"
        "me.iepure.devtoolbox"
        "io.github.dvlv.boxbuddyrs"
        "com.mattjakeman.ExtensionManager"
        "com.calibre_ebook.calibre"
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
