{
  description = "bradfordfults.com — Rails/Perron static site";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        # Ruby 3.4.x per .tool-versions; nixpkgs unstable may be a patch or
        # two ahead of the exact pin.
        ruby = pkgs.ruby_3_4;
      in
      {
        devShells.default = pkgs.mkShell {
          # Ruby, bundler, and goreman (bin/dev's Procfile runner). No
          # postgres/DB here — this app has no database, it's a static
          # site generator (see Perron in the Gemfile).
          packages = [
            ruby
            pkgs.bundler
            pkgs.goreman
          ];

          shellHook = ''
            # Keep gems inside the project instead of ~/.gem.
            export GEM_HOME="$PWD/.gem"
            export PATH="$GEM_HOME/bin:$PATH"

            echo "bradfordfults.com devShell — $(ruby --version)"
          '';
        };
      });
}
