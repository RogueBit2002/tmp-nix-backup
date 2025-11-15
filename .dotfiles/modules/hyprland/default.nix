{ config, pkgs, ...}:

{
	wayland.windowManager.hyprland = {
		enable = true;
		xwayland.enable = true;

		settings = {
			xwayland = {
				force_zero_scaling = true;
			};

			"$mod" = "SUPER";
			
			bind = [				
				"$mod_Control, K, exit,"
				"$mod, Return, exec, kitty"
			];

			misc = {
				force_default_wallpaper = -1;
				disable_hyprland_logo = true;
				disable_splash_rendering = true;
			};

		};

		
    };

	imports = [ 
		./input.nix 
		./style.nix
		./behavior.nix
	];

	home.activation.reloadHyprland = "${pkgs.hyprland}/bin/hyprctl reload";
}