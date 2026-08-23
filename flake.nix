{
  description = "Moldy NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.url = "github:NixOS/nixpkgs/4df1b885d76a54e1aa1a318f8d16fd6005b6401f";
    };
    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, home-manager, ... }@inputs: {
    nixosConfigurations = {

      fw12 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/fw12
          disko.nixosModules.disko
          home-manager.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.myco = import ./modules/myco/fw12.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };

      mycorrhiza = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/mycorrhiza
          disko.nixosModules.disko
          home-manager.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.myco = import ./modules/myco/mycorrhiza.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };

    };
  };
}
