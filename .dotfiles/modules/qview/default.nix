{ pkgs, ... }: {
	home.packages = with pkgs; [ qview ];

	xdg.configFile."qView/qView.conf".text = ''
		[General]
		configversion = 6.1
		firstlaunch = true

		[options]
		updatenotifications=false
	'';

}