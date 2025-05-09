_: {
  imports = [
    ./packages
  ];

  programs = {
    zsh.enable = true;
    gnupg.agent.enable = true;
    ssh = {
      startAgent = true; #NOTE: Auto-start ssh-add agent
      enableAskPassword = true;
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = false;
    };
  };
}
