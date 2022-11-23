{ builders, nixpakModules, pkgs, ... }:

{
  packages.gnome-maps = builders.mkNixPakPackage {
    config = {
      app.package = pkgs.gnome.gnome-maps;
      flatpak.appId = "org.gnome.Maps";
      imports = [
        nixpakModules.gui-base
        nixpakModules.network
      ];
    };
  };
}
