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
    gcc
    gnumake
    ripgrep
    nix-output-monitor
    home-manager
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
  programs.ssh = {
    startAgent = true; #NOTE: Auto-start ssh-add agent
    enableAskPassword = true;
  };

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
  };

  system.stateVersion = "24.11";
}
