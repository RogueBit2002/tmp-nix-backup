{ ... }: {

	wayland.windowManager.hyprland = {
		#enable = true;
		xwayland.enable = true;

		settings = {
			xwayland = {
				force_zero_scaling = true;
			};

			"$mod" = "SUPER";
			
			bind = [				
				"$mod_Control, K, exit,"
			];

			misc = {
				force_default_wallpaper = -1;
				disable_hyprland_logo = true;
				disable_splash_rendering = true;
			};

		};
	};

	imports = [
		./behavior.nix
		./input.nix
		./style.nix
	];
}