{
	description = "A nixvim configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixvim.url = "github:nix-community/nixvim";
		flake-parts.url = "github:hercules-ci/flake-parts";
	};

	outputs = { nixvim, flake-parts, ... } @ inputs: let
		config = import ./config;
	in flake-parts.lib.mkFlake { inherit inputs; } {
		systems = [ "x86_64-linux" ];

		perSystem = { pkgs , system , ... }: let
			nixvimLib = nixvim.lib.${system};
			nixvim' = nixvim.legacyPackages.${system};
			nvim = nixvim'.makeNixvimWithModule {
				inherit pkgs;
				module = config;
				extraSpecialArgs = { inherit inputs; };
			};
		in { packages.default = nvim; };
	};
}
