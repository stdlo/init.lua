{
  description = "The tools this Neovim config needs, for nix develop or nix profile add";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
      ];
      forEachSystem = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
      # The language servers come from here rather than Mason, so they're pinned by
      # flake.lock and carry their own glibc. Mason still installs them on Windows.
      tools =
        pkgs: with pkgs; [
          neovim
          tree-sitter
          git
          ripgrep
          clang-tools
          lua-language-server
          typescript-language-server
        ];
    in
    {
      # nix profile add puts these on the PATH of every shell, for everyday editing.
      packages = forEachSystem (pkgs: {
        default = pkgs.buildEnv {
          name = "nvim-tools";
          paths = tools pkgs;
        };
      });

      # mkShell also brings a C compiler and make, which nvim-treesitter's
      # parser builds and telescope-fzf-native need.
      devShells = forEachSystem (pkgs: {
        default = pkgs.mkShell { packages = tools pkgs; };
      });
    };
}
