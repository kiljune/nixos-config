{
  lib,
  pkgs,
  config,
  ...
}: {
  systemd.tmpfiles.rules = ["L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"];
  services.xserver.videoDrivers = ["amdgpu"];

  # OpenGL
  hardware.graphics = {
    extraPackages = with pkgs; [
      libva
      libva-utils
    ];
  };
}
