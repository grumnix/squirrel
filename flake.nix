{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

    tinycmmc.url = "github:grumbel/tinycmmc";
    tinycmmc.inputs.nixpkgs.follows = "nixpkgs";

    squirrel_src.url = "github:albertodemichelis/squirrel?ref=v3.2";
    squirrel_src.flake = false;
  };

  outputs = { self, nixpkgs, tinycmmc, squirrel_src }:
    tinycmmc.lib.eachSystemWithPkgs (pkgs:
      {
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
      }
    );
}
