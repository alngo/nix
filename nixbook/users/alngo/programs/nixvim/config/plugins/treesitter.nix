{
	plugins = {
		treesitter = {
			enable = true;

			nixvimInjections = true;

			settings = {
				highlight.enable = true;
				indent.enable = true;
				folding.enable = false;
			};
		};

		treesitter-refactor = {
			enable = false;
			settings = {
				highlight_definitions = {
					enable = true;
					clear_on_cursor_move = false;
				};
			};
		};

		hmts.enable = true;
	};
}
