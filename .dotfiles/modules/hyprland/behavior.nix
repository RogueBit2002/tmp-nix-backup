{ config, lib, ...}:
{
	wayland.windowManager.hyprland.settings = {
		general = {
			layout = "dwindle";
			allow_tearing = false;
		};

		input = {
			follow_mouse = 2;
		};
		
		dwindle = {
			pseudotile = true;
			preserve_split = true;
		};

		bind = [
			"$mod, Q, killactive,"

			"$mod, left, movefocus, l"
			"$mod, right, movefocus, r"
			"$mod, up, movefocus, u"
			"$mod, down, movefocus, d"

			"$mod, J, togglesplit"

			# "$mod, S, togglespecialworkspace, beepboop"
			
		] ++ builtins.concatLists (builtins.genList (i: 
			let
				btn = lib.trivial.mod (i + 1) 10;
				workspace = i + 1;
			in
			[
				"$mod, ${builtins.toString btn}, workspace, ${builtins.toString workspace}"
				"$mod SHIFT, ${builtins.toString btn}, movetoworkspace, ${builtins.toString workspace}"
			]
		) 10);

		bindm = [
			"$mod, mouse:272, movewindow"
			"$mod, mouse:273, resizewindow"
		];

	};
}