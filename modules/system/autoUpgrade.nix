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
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L"
    ];
    randomizedDelaySec = "45min";
  };
}
