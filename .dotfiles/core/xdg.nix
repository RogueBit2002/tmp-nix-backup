{ pkgs, config, ... }: {

	xdg.enable = true;

	xdg.enable = true;
	
	xdg.portal = {
		enable = true;
 		#configPackages = [ pkgs.gnome-session ]; #Not sure about this one
		extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
	};

	xdg.userDirs = let
		homeDir = "${config.home.homeDirectory}";
		misc = "${homeDir}/xdg/misc";
	in {
		enable = true;
		createDirectories = true;
		
		#Things I'll actually use
		download = "${homeDir}/downloads";
		extraConfig.XDG_SCREENSHOT_DIR = "${homeDir}/screenshots";
		
		documents = "${misc}";
		pictures = "${misc}";
		videos = "${misc}";
		music = "${misc}";
		
		desktop = "${homeDir}/xdg/desktop";
		templates = "${homeDir}/xdg/templates";
		publicShare = "${homeDir}/xdg/public";
	};
}