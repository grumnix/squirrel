{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    tinycmmc.url = "github:grumbel/tinycmmc";
    tinycmmc.inputs.nixpkgs.follows = "nixpkgs";

    squirrel_src.url = "github:albertodemichelis/squirrel?rev=b31e5bdc213359f6612e77d36bae26fa85424c56";
    squirrel_src.flake = false;
  };

  outputs = { self, nixpkgs, tinycmmc, squirrel_src }:
    tinycmmc.lib.eachSystemWithPkgs (pkgs:
      rec {
        packages = rec {
          default = squirrel;

          squirrel = pkgs.stdenv.mkDerivation {
            pname = "squirrel";
            version = "3.2";

            src = squirrel_src;

            nativeBuildInputs = [
              pkgs.buildPackages.cmake
            ];
          };
        };

        apps = rec {
          default = sq;

          sq = {
            type = "app";
            program = "${packages.squirrel}/bin/sq";
          };
        };
      }
    );
}
