# Users - NOTE: Packages defined on this will be on current user only
{
  pkgs,
  inputs,
  userSettings,
  ...
}: {
  users = {
    mutableUsers = true;
    users."${userSettings.username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${userSettings.name}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "scanner"
        "lp"
        "video"
        "input"
        "audio"
      ];

      # define user packages here
      packages = with pkgs; [
      ];
    };
    defaultUserShell = pkgs.zsh;
  };
  nix.settings.trusted-users = ["@wheel"];
  nix.settings.allowed-users = ["${userSettings.username}"];
  environment.shells = with pkgs; [bash zsh fish];
  environment.systemPackages = with pkgs; [starship lsd fzf];

  programs = {
    fish.enable = true;

    # Zsh configuration
    zsh = {
      enable = true;
      enableCompletion = true;

      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      #promptInit = ''
      #  fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

      #  #pokemon colorscripts like. Make sure to install krabby package
      #  #krabby random --no-mega --no-gmax --no-regional --no-title -s;

      #  source <(fzf --zsh);
      #  HISTFILE=~/.zsh_history;
      #  HISTSIZE=10000;
      #  SAVEHIST=10000;
      #  setopt appendhistory;
      #'';
    };
  };
}
