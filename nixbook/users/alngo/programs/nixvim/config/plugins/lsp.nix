{ ... }:
{
	diagnostic.settings.virtual_text = true;
  plugins = {
    lsp-lines.enable = true;
    lsp-format = {
		  enable = true;
			lspServersToEnable = "all";
		};
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        superhtml.enable = true;
        lua_ls.enable = true;
        ts_ls.enable = true;
        marksman.enable = true;
        pyright.enable = true;
        nixd.enable = true;
      };
    };
    rustaceanvim.enable = true;
  };
}
