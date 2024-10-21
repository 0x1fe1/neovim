{ inputs , pkgs , lib , ... }: let
	# from github.com/mrcjkb/kickstart-nix.nvim
	mkNvimPlugin = src: pname:
		pkgs.vimUtils.buildVimPlugin {
			inherit pname src;
			version = src.lastModifiedDate;
		};

	keymaps = import ./keymaps.nix { inherit lib; };
	plugins = import ./plugins.nix { inherit pkgs; };
in {
	# Import all your configuration modules here
	imports = [
		plugins
		./options.nix
		keymaps
	];

	config = {
		# colorschemes.tokyonight.enable = true;
		# colorschemes.gruvbox.enable = true;
		colorschemes.catppuccin.enable = true;
		globals.mapleader = " ";

		clipboard = {
			register = "unnamedplus";
			providers.xclip.enable = true;
			# providers.wl-copy.enable = true;
		};

		extraPlugins = with pkgs.vimPlugins; [
			vim-move
			harpoon2
		];

		extraFiles = {
			"ftplugin/gleam.lua".text = ''
				vim.opt.comments="://"
				vim.opt.commentstring = "// %s"
			'';
			# "ftplugin/toml.lua".text = text;
			# "ftplugin/c.lua".text = text;
		};

		# extraPackages = with pkgs; [ ];

		autoCmd = [
			# Highlight on Yank
			{
				event = [ "TextYankPost" ];
				pattern = [ "*" ];
				group = "YankHighlight";
				callback = {
					__raw = ''
						function()
							vim.highlight.on_yank({
								higroup = 'IncSearch',
								timeout = 40,
							})
						end
					'';
				};
			}
		];

		autoGroups = {
			YankHighlight.clear = true;
		};

		extraConfigLuaPost = /* lua */ ''
			require("harpoon"):setup()
			-- HACK vim.g.loaded_matchparen = 1
			-- ^^^ fix some weird harpoon-related issue, when accessing a 4th buffer that starts with the same bracket

			-- Open help window in a vertical split to the right.
			vim.api.nvim_create_autocmd("BufWinEnter", {
					group = vim.api.nvim_create_augroup("help_window_right", {}),
					pattern = { "*.txt" },
					callback = function()
							if vim.o.filetype == 'help' then vim.cmd.wincmd("L") end
					end
			})
		'';
	};
}
