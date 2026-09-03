{
  description = "Moldy NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    maple-mono = {
      url = "github:subframe7536/maple-font";
      flake = false;
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: 
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

        fw12 = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/fw12 ];
          specialArgs = {
            host = "fw12";
            inherit self inputs username;
          };
        };
	mycorrhiza = nixpkgs.lib.nixosSystem {
	  inherit system;
	  modules = [ ./hosts/mycorrhiza ];
	  specialArgs = {
	    host = "mycorrhiza";
	    inherit self inputs username;
	  };
	};

      };
    };
}
