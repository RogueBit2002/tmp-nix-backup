{ config, ... }:
{
	wayland.windowManager.hyprland.settings = {
		general = {
			gaps_in = 2;
			gaps_out = 6;
			border_size = 2;

			"col.active_border" = "rgba(ff0000ff) rgba(0000ffff) 90deg";
			"col.inactive_border" = "rgba(00ff00ff)";
		};

		animations = {
			enabled = false;
		};

		decoration = {
			rounding = 6;
			
			blur = {
				enabled = true;
				size = 4;
				passes = 1;
			};

			shadow.enabled = false;
		};
	};
}