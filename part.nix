{ inputs, ... }:
let
  inherit (inputs.nixpak.inputs) nixpkgs;
in
{
  systems = [
    "x86_64-linux"
    "aarch64-linux"
  ];
  perSystem = { pkgs, system, ... }: {
    _module.args.pkgs = nixpkgs.legacyPackages.${system};
    builders.mkNixPakPackage = args: let
      mkNixPak = inputs.nixpak.lib.nixpak {
        inherit (nixpkgs) lib;
        inherit pkgs;
      };
      pkg = mkNixPak args;
    in pkg.config.env;

    imports = [
      ./pkgs
    ];
  };
}
