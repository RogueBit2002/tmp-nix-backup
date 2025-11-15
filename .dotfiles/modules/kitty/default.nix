{ pkgs, ... }: {
	programs.kitty = {
		enable = true;

		settings = {
			font_family = "family=\"0xProto Nerd Font Mono\"";
			bold_font = "auto";
			italic_font = "auto";
			bold_italic_font = "auto";
		};
	};
}