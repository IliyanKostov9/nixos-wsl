{pkgs, ...}: {
  imports = [
    ./packages
  ];

  fonts.packages = with pkgs.nerd-fonts; [
    _0xproto
    fira-code
  ];
  programs = {
    zsh.enable = true;
    gnupg.agent.enable = true;
    seahorse.enable = true;
    ssh = {
      startAgent = true; # NOTE: Auto-start ssh-add agent
      enableAskPassword = true;
      askPassword = "seahorse";
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = false;
    };
  };
}
