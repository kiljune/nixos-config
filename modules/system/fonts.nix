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
  # FONTS
  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    noto-fonts-cjk-sans
    jetbrains-mono
    material-icons
    font-awesome
    terminus_font
    victor-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.caskaydia-cove
    nerd-fonts.iosevka
    nerd-fonts.caskaydia-mono
    nerd-fonts.iosevka-term-slab
  ];
}
