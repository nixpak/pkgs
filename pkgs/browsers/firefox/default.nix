{
  builders,
  nixpakModules,
  pkgs,
  ...
}: {
  packages.firefox = builders.mkNixPakPackage {
    config = {
      config,
      sloth,
      ...
    }: {
      app.package = pkgs.firefox;
      app.binPath = "bin/firefox";
      flatpak.appId = "org.mozilla.firefox";

      imports = [
        nixpakModules.gui-base
        nixpakModules.network
      ];

      # https://github.com/schizofox/schizofox/blob/main/modules/hm/default.nix
      dbus.policies = {
        "org.mozilla.firefox.*" = "own";        # firefox
        # "org.mozilla.firefox_beta.*" = "own"; # firefox beta (?)
        # "io.gitlab.librewolf.*" = "own";      # librewolf
      };

      bubblewrap = let
        envSuffix = envKey: sloth.concat' (sloth.env envKey);
      in {
        bind.rw = [
          (sloth.concat' sloth.homeDir "/.mozilla")
          (sloth.concat' sloth.homeDir "/Downloads")

          # Unsure
          "/tmp/.X11-unix"
          (sloth.envOr "XAUTHORITY" "/no-xauth")
          (envSuffix "XDG_RUNTIME_DIR" "/dconf")
        ];
        bind.ro = [
          # To actually make Firefox run
          "/sys/bus/pci"
          ["${config.app.package}/lib/firefox" "/app/etc/firefox"]

          # Use correct timezone
          "/etc/localtime"

          # Unsure
          (sloth.concat' sloth.xdgConfigHome "/dconf")
        ];
      };
    };
  };
}

