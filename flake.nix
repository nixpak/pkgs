{
  description = "NixPak Packages";
  inputs = {
    nixpak.url = "github:nixpak/nixpak";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpak/nixpkgs";
    };
    hercules-ci-effects = {
      url = "github:hercules-ci/hercules-ci-effects";
      inputs = {
        nixpkgs.follows = "nixpak/nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
  };
  outputs = { flake-parts, ... }@inputs: flake-parts.lib.mkFlake { inherit inputs; } {
    imports = [
      inputs.hercules-ci-effects.flakeModule
      ./jobs/update-flake-lock
      ./part.nix
      ./modules/builders.nix
    ];
  };
}
