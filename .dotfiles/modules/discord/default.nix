{ pkgs, config, ... }: {
	
	home.activation.discordSetup = let 
		flatpak = "/run/current-system/sw/bin/flatpak";
	in ''
		if ! ${flatpak} info com.discordapp.Discord > /dev/null 2>&1; then
			${flatpak} install --user  --assumeyes --from https://flathub.org/repo/appstream/com.discordapp.Discord.flatpakref
		fi
	'';
}