{
  description = "Moldy NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    }

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    maple-mono = {
      url = "github:subframe7536/maple-font?ref=v7.8";
      flake = false;
    };
  };


  outputs =
    { nixpkgs, self, ... }@inputs:
    let
      username = "myco";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        mycorrhiza = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/mycorrhiza ];
          specialArgs = {
            host = "mycorrhiza";
            inherit self inputs username;
          };
        };
        fw12 = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/fw12 ];
          specialArgs = {
            host = "fw12";
            inherit self inputs username;
          };
        };
      };
    };
}
