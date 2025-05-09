{
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [
    eza
    bat
    fzf
  ];
}
