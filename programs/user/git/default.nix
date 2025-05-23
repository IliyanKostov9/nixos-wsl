{
  pkgs,
  lib,
  config,
  user,
  ...
}:
with lib;
with lib.types; let
  cfg = config.modules.git;
  git-all =
    pkgs.writeShellApplication
    {
      name = "git-all";
      runtimeInputs = with pkgs; [git git-extras];
      text = ''
        git_message="$*"

        git add .
        git-magic -m "''${git_message}" -p
      '';
    };
  git-rm-local-brv =
    pkgs.writeShellApplication
    {
      name = "git-rm-local-brv";
      runtimeInputs = [pkgs.git];
      text = ''
        git fetch -p && \
          for branch in ''$(LC_ALL=C git branch -vv | grep ': gone]' | awk '{print $1}');
            do
              git branch -D "''$branch";
            done
      '';
    };
  git-history-rebase =
    pkgs.writeShellApplication
    {
      name = "git-history-rebase";
      runtimeInputs = [pkgs.git];

      text = builtins.readFile ./bin/bash/git-history-rebase.sh;
    };
in {
  options.modules.git = {
    enable = mkEnableOption "git";

    userName = mkOption {
      type = str;
      default = "john-doe";
      description = mkDoc ''
        Username for git
      '';
    };
    userEmail = mkOption {
      type = str;
      default = "john.doe@mail.com";
      description = mkDoc ''
        Email for git
      '';
    };

    shouldGPGSign = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Sign git commits via GPG
      '';
    };
    gpgKey = mkOption {
      type = str;
      default = "";
      description = mkDoc ''
        KEY ID of GPG key to sign
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      git-all
      git-rm-local-brv
      git-extras
      git-history-rebase
    ];

    programs.git = {
      enable = true;
      inherit (cfg) userName userEmail;
      ignores = [
        "*~"
        "*.swp"
      ];
      signing = {
        signByDefault = cfg.shouldGPGSign;
        key = cfg.gpgKey;
      };

      extraConfig = {
        diff.colorMoved = true;
        pull.rebase = false;
        push.autoSetupRemote = true;
        safe.directory = "/etc/nixos";
        init.defaultBranch = "master";
        core = {
          hooksPath = "/home/${user}/.git/hooks";
          editor = "nvim";
        };
      };
    };
  };
}
