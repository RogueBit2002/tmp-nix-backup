{ pkgs, ... }: {
	home.packages = with pkgs; [
		libreoffice-qt6-fresh
		hunspell
		hunspellDicts.en-us-large
		hunspellDicts.nl_NL
	];
}