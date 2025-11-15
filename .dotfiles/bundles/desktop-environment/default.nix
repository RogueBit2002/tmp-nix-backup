{ pkgs, config, lib, ... }: let
	monitorType = lib.types.submodule {
		options = {
			resolution = lib.mkOption {
				type = lib.types.nullOr lib.types.str;
				default = null;
				description = "The resulution of the monitor";
			};

			refreshRate = lib.mkOption {
				type = lib.types.nullOr (lib.types.numbers.between 0 999);
				default = null;
				description = "Refresh rate of the monitor";
			};

			scale = lib.mkOption {
				type = lib.types.float;
				default = 1.0;
				description = "Scale of the monitor";
			};

			rotation = lib.mkOption {
				type = lib.types.int;
				default = 0;
				description = "Rotation of display";
			};

			position = lib.mkOption {
				type = lib.types.nullOr lib.types.str;
				default = null;
				description = "";
			};

			wallpaper = lib.mkOption {
				type = lib.types.nullOr lib.types.path;
				default = null;
				description = "Wallpaper for the monitor";
			};

			workspaces = lib.mkOption {
				type = lib.types.listOf lib.types.int;
				default = [];
				description = "Workspaces tied to the monitor";
			};


		};
	};


	cfg = config._bundle.desktopEnvironment;

in {
	
	/*
	Hyprland
		Monitors
	Kitty
	Clipse
	Bemenu
	Zoxide
	Swaybg

	*/
	options = {
		_bundle.desktopEnvironment = {
			enable = lib.mkEnableOption ":)";

			monitors = lib.mkOption { default = {}; type = lib.types.attrsOf monitorType; };
		};
	};

	imports = [ ./hyprland ];
	config = lib.mkIf cfg.enable {
		

		/*
			SUPER + Q = Quit application
			SUPER + CTRL + K = Kill Hyprland

			SUPER + ENTER = Kitty
			SUPER + S = Screenshot
			SUPER + R = Bemenu
			SUPER + H = Clipse
			SUPER + N = Notifications
		*/
		wayland.windowManager.hyprland.enable = true;
		wayland.windowManager.hyprland.settings.bind = [
			"$mod, Q, killactive,"
			"$mod, Return, exec, kitty"
			"$mod, R, exec, bemenu-run --single-instance --prompt \"run >\""
		];

		wayland.windowManager.hyprland.settings.monitor = builtins.map
			(id: let
				monitor = cfg.monitors.${id};

				mode = if monitor.resolution == null && monitor.refreshRate == null then "preferred"
				else if monitor.resolution != null && monitor.refreshRate == null then "${monitor.resolution}"
				else if monitor.resolution != null && monitor.refreshRate != null then "${monitor.resolution}@${toString monitor.refreshRate}"
				else throw "Refresh rate requires resolution";
				
				position = if monitor.position == null then "auto" else monitor.position;
				scale = monitor.scale;
				rotation = monitor.rotation;

			in "${id}, ${mode}, ${position}, ${toString scale}, transform, ${toString rotation}")
			(builtins.attrNames cfg.monitors);

		wayland.windowManager.hyprland.settings.workspace = builtins.foldl'
			(acc: elem: acc ++ elem)
			[]
			(builtins.map
				(id: builtins.map (wid: "${toString wid}, monitor:${id}") cfg.monitors.${id}.workspaces)
				(builtins.attrNames cfg.monitors)
			);

		programs.kitty = {
			enable = true;

			settings = {
				font_family = "family=\"0xProto Nerd Font Mono\"";
				bold_font = "auto";
				italic_font = "auto";
				bold_italic_font = "auto";
			};
		};

		programs.zoxide = {
			enable = true;
			options = [ "--cmd cd" ];
		};


		

		home.packages = with pkgs; [ pkgs.pavucontrol bemenu ];


		services.clipse = {
			enable = true;
			imageDisplay.type = "kitty";
		};


		systemd.user.services.swaybg-wallpaper = {
			Unit = {
				Description = "Wallpaper";
				After = [ "graphical-session.target" ];
			};

			Service = {
				Type = "simple";
				ExecStart = let
					arguments = builtins.foldl' (acc: elem: "${acc} ${elem}")
						""
						(builtins.map (id: let
							monitor = cfg.monitors.${id};

							in 
								if monitor.wallpaper != null then "--output \"${id}\" --image ${monitor.wallpaper}" else "")
						(builtins.attrNames cfg.monitors));

				in pkgs.writeShellScript "swaybg-wallpaper-script" ''
					${pkgs.swaybg}/bin/swaybg ${arguments}
				'';
			};

			Install = {
				WantedBy = [ "graphical-session.target" ];
			};
		};

		systemd.user.services.clipseListen = {
			Unit = {
				Description = "Clipboard histrory listener";
				After = [ "multi-user.target" ];
			};

			Service = {
				Type = "oneshot";
				RemainAfterExit=true;
				ExecStart = "${config.services.clipse.package}/bin/clipse -listen";
				ExecStop = "${config.services.clipse.package}/bin/clipse -kill";
			};

			Install = {
				WantedBy = [ "multi-user.target" ];
			};
		};
	};
}




/*

imports = [ ../bundles/desktop-environment ];

_bundle.desktopEnvironment.enable = true;
_bundle.desktopEnvironment.monitors = {
	"DP-4" = {
		resolution = "2560x1440"
		refreshRate = 180;
	};

	"DP-9" = {
		position = 
		rotation = 3;
		scale = 0.83;
		resolution = "1920x1080";
		refreshRate = 74.97;
	};

	"DP-10" = {
		rotation = 1;
		scale = 0.83;
		resolution = "1920x1080";
		refreshRate = 74.97;
	};
};

*/