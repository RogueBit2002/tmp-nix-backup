{ pkgs, ... }: {
	networking.networkmanager.enable = true;
	networking.useDHCP = pkgs.lib.mkDefault true;
	networking.domain = "crowsnest.local";
}
