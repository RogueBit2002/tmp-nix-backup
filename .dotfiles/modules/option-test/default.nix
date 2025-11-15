{ config, pkgs, lib, ... }: let
	# define the per-item type: an attribute-set with `foo` and `bar` strings
	perItemType = lib.types.submodule {
		options = {
			foo = lib.mkOption {
				type = lib.types.str;
				description = "The foo string for this item.";
			};

			bar = lib.mkOption {
				type = lib.types.str;
				description = "The bar string for this item.";
			};
		};
	};
in {
	options = {
		# top-level module enable (optional)
		testModule.enable = lib.mkEnableOption "Enable the example module.";

		# the option you asked for: a map of id -> { foo, bar }
		testModule.items = lib.mkOption {
			type = lib.types.attrsOf perItemType;
			default = {};
			description = "Map of items keyed by id. Each item must provide `foo` and `bar` (strings).";
			example = {
				alice = { foo = "hello"; bar = "world"; };
				bob   = { foo = "x";     bar = "y";     };
			};
		};
	};


	config = lib.mkIf config.testModule.enable (let
    	items = config.myModule.items;
  	in
	{
		home.file."__t".text = builtins.foldl' (acc: elem: acc + "\n${elem.foo} :: ${elem.bar}") "" (builtins.attrValues config.testModule.items);
	});
}