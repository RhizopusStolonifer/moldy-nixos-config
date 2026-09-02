{
  description = "Moldy NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
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
