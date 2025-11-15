{ pkgs, ... }: {
	services.flatpak.enable = true;
	#system.activationScripts.flatpakSetup.deps = 
	system.activationScripts.flatpakSetup.text = "${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo";

	xdg.portal.enable = true;
	xdg.portal.config.common = {
		default = [
			"gtk"
		];
	};
	xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
}