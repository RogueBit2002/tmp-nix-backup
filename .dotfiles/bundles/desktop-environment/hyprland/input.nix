{ config, pkgs, ...}:
{
	wayland.windowManager.hyprland.settings = {
		input = {
			kb_layout = "us";
			touchpad = {
				natural_scroll = true;
			};


			accel_profile="flat";
			sensitivity = 0;
		};
	};
}