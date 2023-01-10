{
  description = "NixPak Packages";
  inputs = {
    nixpak.url = "github:nixpak/nixpak";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpak/nixpkgs";
    };
  };
  outputs = { flake-parts, ... }@inputs: flake-parts.lib.mkFlake { inherit inputs; } {
    imports = [
      ./part.nix
      ./modules/builders.nix
    ];
  };
}
