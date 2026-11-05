{
  description = "The tools this Neovim config needs, for nix develop";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
      ];
      forEachSystem = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forEachSystem (pkgs: {
        # mkShell also brings a C compiler and make, which nvim-treesitter's
        # parser builds and telescope-fzf-native need.
        default = pkgs.mkShell {
          packages = with pkgs; [
            neovim
            tree-sitter
            git
            ripgrep
          ];
        };
      });
    };
}
