{
  pkgs,
  config,
  options,
  lib,
  inputs,
  system,
  ...
}: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
  };

  environment.systemPackages = with pkgs; [
    tree-sitter
    nixd
  ];
}
