mount: { pkgs, lib, config, ...}: let 
	cfg = config.${mount};
in {

	options = {
		"${mount}" = {
			enable = lib.mkEnableOption ":D";
		};
	};

	config = lib.mkIf cfg.enable {

		home.packages = with pkgs; [ qview xfce.thunar ];

		programs.librewolf = {
			enable = true;
			settings = {
				"webgl.disabled" = false;
				"privacy.resistFingerprinting" = true;
			};
		};

		xdg.configFile."qView/qView.conf".text = ''
			[General]
			configversion = 6.1
			firstlaunch = true

			[options]
			updatenotifications=false
		'';
	};
}