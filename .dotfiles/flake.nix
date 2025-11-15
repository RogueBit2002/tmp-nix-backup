{
	description = "Home-Manager flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

		home-manager = {
			url = "github:nix-community/home-manager/release-25.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		hyprcursor = {
			url = "github:hyprwm/hyprcursor/v0.1.13";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		ags = {
			url = "github:aylur/ags/v2.3.0";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
	
	outputs = { nixpkgs, home-manager, ... } @ inputs: let
		system = "x86_64-linux";
		pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };

		flib = import ./lib.nix { rootDir = ./.; };

		mkHome = username: host: wrap: 
		let
			homeConfig = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;

				extraSpecialArgs = {
					flakeInputs = inputs;
					inherit flib;
				};

				modules = [{
						programs.home-manager.enable = true;

						programs.bash.enable = true;
						home = {
							inherit username;
							homeDirectory = "/home/${username}";
							stateVersion = "25.05";
						};
					}
					(toString ./hosts/${host}.nix)
				];
			};
		in if wrap then { "${username}@${host}" = homeConfig; } else homeConfig;
	in {

		homeConfigurations =  mkHome "laurens" "workstation" true; /*builtins.foldl' (acc: home: acc // home ) {} [ 
			(mkHome "laurens" "workstation" true)
			#mkHome "laurens" "laptop" true
		];*/
	};
}
