{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    killall
    pciutils
    lazygit
    ripgrep
    tldr
    nvtopPackages.full
    rustup
    clang
    lldb
    gcc
    gdb
    cmake
    gnumake
    tmux
  ];
}
