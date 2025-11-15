{
	description = "System base configuration";

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

					boot.kernelPackages = pkgs.linuxPackages_latest;

					systemd.services.setPerformance = {
						script = ''
							for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
								echo "performance" > "$cpu"
							done
						'';
						serviceConfig = {
        					Type = "oneshot";
						};
						wantedBy = [ "multi-user.target" ];
					};

				}

				./old/flake/modules/hardware.nix
				./old/flake/modules/boot.nix
				./old/flake/modules/display.nix
				./old/flake/modules/networking.nix
				./old/flake/modules/audio.nix
				./old/flake/modules/locale.nix
				./old/flake/modules/users.nix
				./old/flake/modules/packages.nix

				./modules/flatpak
			];
		};
	};
}
