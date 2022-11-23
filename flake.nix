{
  description = "NixPak Packages";
  inputs = {
    nixpak.url = "github:nixpak/nixpak";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
  };
  outputs = { self, nixpak, flake-parts }: flake-parts.lib.mkFlake { inherit self; } {
    imports = [
      ./part.nix
      ./modules/builders.nix
    ];
  };
}
