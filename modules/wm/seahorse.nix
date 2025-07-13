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
  programs.seahorse.enable = true;
  programs.ssh = {
    enableAskPassword = true;
    askPassword = "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";
  };
  #security.pam.services = {
  #  greetd.enableGnomeKeyring = true;
  #  greetd-password.enableGnomeKeyring = true;
  #  login.enableGnomeKeyring = true;
  #};
}
