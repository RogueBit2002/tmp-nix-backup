{ pkgs, config, ... }: 
let 
	/*clipse2Script = pkgs.writeShellScriptBin "clipse-ui-internal" ''
		clipse; exit;
		# Read from socket and log
	'';

	clipseScript = pkgs.writeShellScriptBin "clipse-ui" ''
		
		FILE="/run/user/$UID/clipse.lock"
		(
			flock -n 200 || { exit 1; }
			kitty --app-id "clipse" bash -c "clipse; exit"
			echo "Done"
		) 200>$FILE
	'';*/
in {

	imports = [
		./../bundles/desktop-environment

		#essentials
		((import ../bundles/essentials) "essentials")

		#gaming
		./../modules/steam
		./../modules/discord
		
		#coding
		./../modules/vscode
		
		#office
		./../modules/thunderbird
		./../modules/libreoffice
	];

	essentials = {
		enable = true;
	};

	_bundle.desktopEnvironment = {
		enable = true;
		monitors = {
			#Left
			"DP-10" = {
				rotation = 1;
				scale = 0.8;
				resolution = "1920x1080";
				refreshRate = 74.97;
				position = "0x0";
				wallpaper = ../resources/wallpapers/desert/desert_left.png;
				workspaces = [ 5 6 7 ];
			};

			#Center
			"DP-4" = {
				resolution = "2560x1440";
				refreshRate = 180;
				position = "1350x0";
				wallpaper = ../resources/wallpapers/desert/desert_center.png;
				workspaces = [ 1 2 3 4 ];
			};

			#Right
			"DP-9" = {
				rotation = 3;
				scale = 0.8;
				resolution = "1920x1080";
				refreshRate = 74.97;
				position = "${toString (1350 + 2560)}x0";
				wallpaper = ../resources/wallpapers/desert/desert_right.png;
				workspaces = [ 8 9 10 ];
			};
		};
	};


	home.packages = [ pkgs.pavucontrol pkgs.gimp3-with-plugins ];

	home.file.".local/share/fonts/FiraCode".source = ../resources/fonts/FiraCode;
	home.file.".local/share/fonts/Hasklug".source = ../resources/fonts/Hasklug;
	home.file.".local/share/fonts/0xProto".source = ../resources/fonts/0xProto;
	home.file.".local/share/icons/hyprcursor-bibata-modern-classic".source = ../resources/cursors/hyprcursor-bibata-modern-classic;
	xdg.configFile."gtk-3.0/settings.ini".text = ''
			[Settings]
			gtk-application-prefer-dark-theme=1
		'';


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