{ pkgs ? import <nixpkgs> {} }: {
	config.plugins = {
		lualine			= { enable = true; };
		rainbow-delimiters	= { enable = true; };
		transparent		= { enable = true; };
		trim			= { enable = true; };
		undotree		= { enable = true; };

		nvim-colorizer = {
			enable = true;
			userDefaultOptions = {
				RGB = true;
				RRGGBB = true;
				RRGGBBAA = true;
				css_fn = true;
				names = false;
				mode = "virtualtext";
				virtualtext = "██";
			};
		};

		treesitter = {
			enable = true;
			settings.highlight.enable = true;
		};

		oil = {
			enable = true;
			settings = {
				skip_confirm_for_simple_edits = true;
				delete_to_trash = true;
			};
		};

		fzf-lua = {
			enable = true;
			settings.winopts.preview.default = "bat";
			keymaps = {
				"<leader>sb" = {
					action = "buffers";
					options.desc = "[S]earch [B]uffers (Fzf-Lua)";
				};
				"<leader>sf" = {
					action = "files";
					options.desc = "[S]earch [F]iles (Fzf-Lua)";
				};
				"<leader>st" = {
					action = "tags_live_grep";
					options.desc = "[S]earch [T]ags (Fzf-Lua)";
				};
				"<leader>sg" = {
					action = "live_grep";
					options.desc = "[S]earch [G]rep (Fzf-Lua)";
				};
				"<leader>sr" = {
					action = "resume";
					options.desc = "[S]earch [R]esume (Fzf-Lua)";
				};
				"<leader>sh" = {
					action = "helptags";
					options.desc = "[S]earch [H]elp (Fzf-Lua)";
				};
				"<leader>sm" = {
					action = "manpages";
					options.desc = "[S]earch [M]anpages (Fzf-Lua)";
				};
				"<leader>sd" = {
					action = "diagnostics_document";
					options.desc = "[S]earch [D]iagnostics (Fzf-Lua)";
				};
				"<leader>sl" = {
					action = "lsp_finder";
					options.desc = "[S]earch [L]sp (Fzf-Lua)";
				};
			};
		};
	};
}
