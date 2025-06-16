{
  description = "My nixos-config";

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    disko,
    impermanence,
    ...
  }: let
    systemSettings = {
      system = "x86_64-linux";
      hostname = "nixos-desktop";
      timezone = "Asia/Seoul";
      keyboard = "us";
      locale = "en_US.UTF-8";
      locale_ko = "ko_KR.UTF-8";
      gpu = "amd";
    };
    userSettings = rec {
      username = "kiljune";
      name = "Kiljune Choi";
      email = "kiljune@gmail.com";
      wm = "gnome";
    };
    system = systemSettings.system;
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in {
    formatter."${system}" = nixpkgs.legacyPackages.${system}.alejandra;

    nixosConfigurations = {
      "${systemSettings.hostname}" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system;
          inherit inputs;
          inherit systemSettings;
          inherit userSettings;
        };
        modules = [
          inputs.disko.nixosModules.default
          (import ./hosts/${systemSettings.hostname}/disko.nix
            {device = "/dev/disk/by-id/ata-2.5__SSD_512GB_CL2025022400573K";})
          inputs.impermanence.nixosModules.impermanence
          #inputs.distro-grub-themes.nixosModules.${system}.default

          ./hosts/${systemSettings.hostname}/configuration.nix
        ];
      };
    };
  };
}
