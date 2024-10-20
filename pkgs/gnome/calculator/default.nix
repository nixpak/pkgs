{ builders, nixpakModules, pkgs, ... }:

# Uses networking to download currency exchange rates
{
  packages.gnome-calculator = builders.mkNixPakPackage {
    config = {
      app.package = pkgs.gnome-calculator;
      flatpak.appId = "org.gnome.Calculator";
      imports = [
        nixpakModules.gui-base
      ];
    };
  };
}
