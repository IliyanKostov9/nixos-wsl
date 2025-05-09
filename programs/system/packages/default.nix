{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    xclip
    vim
    gcc
    gnumake
    ripgrep
    nix-output-monitor
  ];
}
