{
  _module.args.nixpakModules = {
    gui-base = ./modules/gui-base.nix;
    network = ./modules/network.nix;
  };
  imports = [
    ./browsers/chromium
    ./browsers/firefox
    ./gnome/calculator
    ./gnome/maps
  ];
}
