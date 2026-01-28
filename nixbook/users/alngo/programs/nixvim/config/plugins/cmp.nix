{
	opts.completeopt = [
		"menu"
		"menuone"
		"noselect"
	];
	plugins = {

		friendly-snippets.enable = true;
		luasnip.enable = true;

		cmp = {
			enable = true;
			autoEnableSources = true;

			settings = {
				preselect = "cmp.PreselectMode.None";

				snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";

				sources = [
					{
						name = "nvim_lsp";
						priority = 1000;
					}
					{
						name = "nvim_lsp_signature_help";
						priority = 1000;
					}
					{
						name = "nvim_lsp_document_symbol";
						priority = 1000;
					}
					{
						name = "treesitter";
						priority = 850;
					}
					{
						name = "luasnip";
						priority = 750;
					}
					{
						name = "buffer";
						priority = 500;
					}
					{
						name = "path";
						priority = 300;
					}
					{
						name = "cmdline";
						priority = 300;
					}
					{
						name = "calc";
						priority = 150;
					}
					{
						name = "emoji";
						priority = 100;
					}
				];
			};
		};

		lspkind = {
			enable = true;

			cmp = {
				enable = true;
			};
		};
	};
}
