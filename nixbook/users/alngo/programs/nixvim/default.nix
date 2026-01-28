{ pkgs, ... }:
{
	config = {
		globals = {
			mapleader = " ";
		};

		opts = {
			number = true;
			relativenumber = true;
			colorcolumn = "80";
			shiftwidth = 2;
			tabstop = 2;
			hlsearch = true;
			incsearch = true;
		};

		extraPackages = with pkgs; [
			fd
			fzf
			ripgrep
		];

		clipboard = {
			register = "unnamedplus";
		};

		plugins = {
			web-devicons.enable = true;
			gitsigns = {
				enable = true;
				settings.signs = {
					add.text = "+";
					change.text = "~";
				};
			};
			nvim-autopairs.enable = true;
			colorizer = {
				enable = true;
				settings.user_default_options.names = false;
			};
			oil = {
				enable = true;
				lazyLoad.settings.cmd = "Oil";
			};
			trim = {
				enable = true;
				settings = {
					highlight = true;
					ft_blocklist = [
						"checkhealth"
						"floaterm"
						"lspinfo"
						"neo-tree"
						"TelescopePrompt"
					];
				};
			};
			comment = {
				enable = true;
				settings = {
					opleader.line = "<C-b>";
					toggler.line = "<C-b>";
				};
			};
		};
	};



	# Import all your configuration modules here
	imports = [
		./config/plugins/lualine.nix
		./config/plugins/lsp.nix
		./config/plugins/cmp.nix
		./config/plugins/telescope.nix
		./config/plugins/codecompanion.nix
		./config/plugins/treesitter.nix
		./config/mapping.nix
	];

}
