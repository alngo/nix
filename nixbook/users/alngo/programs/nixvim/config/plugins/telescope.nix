{
	plugins = {
		web-devicons.enable = true;
		telescope = {
			enable = true;
			settings.defaults = {
				file_ignore_patterns = [
					"^.git/"
						"^.mypy_cache/"
						"^__pycache__/"
						"^output/"
						"^data/"
						"%.ipynb"
						"%.pdf"
				];
				set_env.COLORTERM = "truecolor";
			};
		};
	};
}
