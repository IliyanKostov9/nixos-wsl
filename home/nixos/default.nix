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
    messaging.enable = true;

    git = {
      enable = true;
      userName = "iliyan-kostov";
      shouldGPGSign = true;
      gpgKey = "B0C7F1D65DEB6718831B5E0E93860C9562C4AA2D";
    };
  };
}
