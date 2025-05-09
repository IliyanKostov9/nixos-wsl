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

    git = {
      enable = true;
      # userName = "iliyan-kostov";
      # userEmail = "iliyan.kostov@email.ikostov.org";
      shouldGPGSign = true;
      # gpgKey = "6105AB13B9DCDD1B";
    };
  };
}
