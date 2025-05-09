{
pkgs,
  ...
}: {
  home.packages = with pkgs; [
    eza
    bat
    fzf
  ];
}
