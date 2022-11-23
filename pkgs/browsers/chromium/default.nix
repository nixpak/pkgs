{ builders, nixpakModules, pkgs, ... }:

{
  packages.chromium = builders.mkNixPakPackage {
    config = { config, sloth, ... }: {
      app.package = pkgs.ungoogled-chromium;
      flatpak.appId = "org.chromium.Chromium";
      imports = [
        nixpakModules.gui-base
        nixpakModules.network
      ];
      bubblewrap = {
        bind.rw = [
          [
            (sloth.mkdir (sloth.concat [
              sloth.appCacheDir
              "/nixpak-app-shared-tmp"
            ]))
            "/tmp"
          ]
          [
            (sloth.mkdir (sloth.concat [
              sloth.appDataDir
              "/profile"
            ]))
            (sloth.concat [
              sloth.xdgConfigHome
              "/chromium"
            ])
          ]
          (sloth.concat' sloth.homeDir "/Downloads")
        ];
      };
    };
  };
}
