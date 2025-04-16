{
  lib,
  pkgs,
  config,
  ...
}: {
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };

  # OpenGL
  hardware.graphics = {
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
      libva
      libva-utils
    ];
  };
}
