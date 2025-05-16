{pkgs, ...}:
pkgs.lib.recursiveUpdate {
  NIX_LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.zlib}/lib:${pkgs.libapparmor}/lib";
  PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  MANPAGER = "nvim +Man!";
  GTK_THEME = "Adwaita:dark";
}
