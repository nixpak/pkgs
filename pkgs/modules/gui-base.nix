{ config, lib, pkgs, sloth, ... }:

let
  envSuffix = envKey: suffix: sloth.concat' (sloth.env envKey) suffix;
in

{
  config = {
    dbus.policies = {
      "${config.flatpak.appId}" = "own";
      "org.freedesktop.DBus" = "talk";
      "org.gtk.vfs.*" = "talk";
      "org.gtk.vfs" = "talk";
      "ca.desrt.dconf" = "talk";
      "org.freedesktop.portal.*" = "talk";
      "org.a11y.Bus" = "talk";
    };
    gpu.enable = lib.mkDefault true;
    gpu.provider = "bundle";
    fonts.enable = true;
    locale.enable = true;
    bubblewrap = {
      network = lib.mkDefault false;
      bind.rw = [
        [
          (envSuffix "HOME" "/.var/app/${config.flatpak.appId}/cache")
          sloth.xdgCacheHome
        ]
        (sloth.concat' sloth.xdgCacheHome "/fontconfig")
        (sloth.concat' sloth.xdgCacheHome "/mesa_shader_cache")

        (sloth.concat [
          (sloth.env "XDG_RUNTIME_DIR")
          "/"
          (sloth.envOr "WAYLAND_DISPLAY" "no")
        ])

        (envSuffix "XDG_RUNTIME_DIR" "/at-spi/bus")
        (envSuffix "XDG_RUNTIME_DIR" "/gvfsd")
        (envSuffix "XDG_RUNTIME_DIR" "/pulse")
      ];
      bind.ro = [
        (envSuffix "XDG_RUNTIME_DIR" "/doc")
        (sloth.concat' sloth.xdgConfigHome "/gtk-2.0")
        (sloth.concat' sloth.xdgConfigHome "/gtk-3.0")
        (sloth.concat' sloth.xdgConfigHome "/gtk-4.0")
        (sloth.concat' sloth.xdgConfigHome "/fontconfig")
      ];
      env = {
        XDG_DATA_DIRS = lib.makeSearchPath "share" [
          pkgs.gnome.adwaita-icon-theme
          pkgs.shared-mime-info
        ];
        XCURSOR_PATH = lib.concatStringsSep ":" [
          "${pkgs.gnome.adwaita-icon-theme}/share/icons"
          "${pkgs.gnome.adwaita-icon-theme}/share/pixmaps"
        ];
      };
    };
  };
}
