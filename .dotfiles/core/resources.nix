{ flib, ...}: {
	home.file."~/.local/share/fonts/FiraCode".source = flib.fromRoot ./resources/fonts/FiraCode;
}