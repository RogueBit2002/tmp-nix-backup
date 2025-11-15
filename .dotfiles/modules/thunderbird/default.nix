{ pkgs, ... }: {
	programs.thunderbird = {
		enable = true;
		
		settings = {
			"privacy.donottrackheader.enabled" = true;
		};

		profiles."Laurens" = {
			isDefault = true;
		};
	};
}