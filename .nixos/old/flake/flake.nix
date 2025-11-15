{
	description = "A very basic flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
	};

	outputs = { self, nixpkgs, ...} @ inputs: let
		system = "x86_64-linux";
		#pkgs = nixpkgs.legacyPackages.${system};
		pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
	in {

		nixosConfigurations.workstation = nixpkgs.lib.nixosSystem {
			inherit system;
			inherit pkgs;

			specialArgs = { flakeInputs = inputs; };

			modules = [
				{
					networking.hostName = "workstation";

					system.stateVersion = "25.05";
					nix.settings.experimental-features = [ "nix-command" "flakes" ];
					#nixpkgs.allowUnfree = true;

				}

				./modules/hardware.nix
				./modules/boot.nix
				./modules/display.nix
				./modules/networking.nix
				./modules/audio.nix
				./modules/locale.nix
				./modules/users.nix
				./modules/packages.nix
			];
		};
	};
}
