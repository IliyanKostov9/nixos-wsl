{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [<nixos-wsl/modules>];

  wsl = {
    enable = true;
    defaultUser = "nixos";
  };
  nix.settings.experimental-features = ["nix-command" "flakes"];
  environment.systemPackages = with pkgs; [
    xclip
    vim
    git
    gcc
    gnumake
    ripgrep
    unzip
  ];

  programs = {
    zsh.enable = true;
    gnupg.agent.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = false;
    };
  };

  system.stateVersion = "24.11";
}
