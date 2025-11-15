{ pkgs, config, ... }: {
	
	home.activation.steamSetup = let 
		dir  = "${config.home.homeDirectory}/games/steam";
		flatpak = "/run/current-system/sw/bin/flatpak";
	in ''
		mkdir -p ${dir}
		if ! ${flatpak} info com.valvesoftware.Steam > /dev/null 2>&1; then
			${flatpak} install --user  --asumeyes --from https://flathub.org/repo/appstream/com.valvesoftware.Steam.flatpakref
		fi

		${flatpak} override --user --filesystem=${dir} com.valvesoftware.Steam
	'';


	/*
	# Doesn't make proton-ge show up in steam
	home.file.".steam/steam/compatibilitytools.d".source = pkgs.fetchzip { 
		url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton10-15/GE-Proton10-15.tar.gz";
		sha256 = "sha256-B10S8e+3aQQQ/dFzzI5ieLp+mRmWanCK7nTuSuSpjVg=";
		stripRoot = false;
	};*/

}