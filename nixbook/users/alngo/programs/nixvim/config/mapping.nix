{ lib, ... }:
{
	keymaps =
		let
			normal =
				lib.mapAttrsToList
				(key: action: {
					mode = "n";
					inherit action key;
				})
				{
					"<Space>" = "<NOP>";
					# Esc to clear search results
					"<esc>" = ":noh<CR>";
					# fix Y behaviour
					Y = "y$";
					# back and fourth between the two most recent files
					"<C-c>" = ":b#<CR>";
					# close by Ctrl+x
					"<C-x>" = ":close<CR>";
					# save by Space+s or Ctrl+s
					"<C-s>" = ":w<CR>";
					# resize with arrows
					"<C-Up>" = ":resize -2<CR>";
					"<C-Down>" = ":resize +2<CR>";
					"<C-Left>" = ":vertical resize +2<CR>";
					"<C-Right>" = ":vertical resize -2<CR>";
					# move current line up/down
					# M = Alt key
					"<M-k>" = ":move-2<CR>";
					"<M-j>" = ":move+<CR>";
				};
			visual =
				lib.mapAttrsToList
				(key: action: {
					mode = "v";
					inherit action key;
				})
				{
					# better indenting
					">" = ">gv";
					"<" = "<gv";
					"<TAB>" = ">gv";
					"<S-TAB>" = "<gv";

					# move selected line / block of text in visual mode
					"K" = ":m '<-2<CR>gv=gv";
					"J" = ":m '>+1<CR>gv=gv";

					# sort
					"<leader>s" = ":sort<CR>";
				};
			extra = [{
				mode = "n";
				key = "<C-t>";
				action.__raw = ''
					function()
						require('telescope.builtin').live_grep({
							default_text="TODO",
							initial_mode="normal"
						})
					end
					'';
				options.silent = true;
			}];
		in
			lib.nixvim.keymaps.mkKeymaps { options.silent = true; } (normal ++ visual ++ extra);

	plugins = {

		# Find TODOs
		cmp = {
			settings = {
				mapping = {
					"<C-d>" = "cmp.mapping.scroll_docs(-4)";
					"<C-f>" = "cmp.mapping.scroll_docs(4)";
					"<C-Space>" = "cmp.mapping.complete()";
					"<C-e>" = "cmp.mapping.close()";
					"<Tab>" = "cmp.mapping(cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}), {'i', 's'})";
					"<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}), {'i', 's'})";
					"<CR>" = "cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace })";
				};
			};
		};

		lsp = {
			keymaps = {
				lspBuf = {
					"gd" = "definition";
					"gD" = "declaration";
					"gi" = "implementation";
					"gr" = "references";
					"gt" = "type_definition";
					"K" = "hover";
				};

				extra = [{
					key = "<leader>ih";
					action = ''vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())'';
				}];
				# -- "grn" is mapped in Normal mode to |vim.lsp.buf.rename()|
				# -- "gra" is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
				# -- "grr" is mapped in Normal mode to |vim.lsp.buf.references()|
				# -- "gri" is mapped in Normal mode to |vim.lsp.buf.implementation()|
				# -- "grt" is mapped in Normal mode to |vim.lsp.buf.type_definition()|
				# -- "gO" is mapped in Normal mode to |vim.lsp.buf.document_symbol()|
				# -- CTRL-S is mapped in Insert mode to |vim.lsp.buf.signature_help()|
				# -- <leader>e to show
			};
		};

		telescope = {
			keymaps = {
				"<leader>ff" = "find_files";
				"<leader>sw" = "live_grep";
				"<leader>scw" = "grep_string";
				"<leader>b" = "buffers";
				"<leader>fh" = "help_tags";
				"<leader>fd" = "diagnostics";
				"<leader><leader>" = "resume";

				"<C-p>" = "git_files";
				"<leader>p" = "oldfiles";
				"<C-f>" = "live_grep";
			};
		};
	};
}
