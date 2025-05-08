{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [<nixos-wsl/modules>];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  environment.systemPackages = with pkgs; [
    xclip
    vim
    neovim
    git
    python310
    gcc
    tmux
    gnumake
    ripgrep
    nodejs_22
    unzip
    awscli2
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "af-magic";
    };
  };

  system.stateVersion = "24.11";
}
