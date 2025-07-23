{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../programs/user
  ];
  config.modules = {
    docker.enable = true;
    neovim.enable = true;
    tmux.enable = true;
    zsh.enable = true;
    chromium.enable = true;

    git = {
      enable = true;
      userName = "iliyan-kostov";
      shouldGPGSign = true;
      gpgKey = "92898C6DC1240F5E0702CE7D82576BD583122E10";
    };
  };
}
