#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

FILE=/run/user/$UID/clipse.lock
(
	flock -n 200 || { exit 1; }
	kitty --app-id "clipse" bash -c "clipse-ui"
) 200>$FILE