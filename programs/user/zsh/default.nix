{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.types; let
  cfg = config.modules.zsh;
  ikostov-zsh-themes = pkgs.fetchFromGitHub {
    owner = "IliyanKostov9";
    repo = "zsh-themes";
    rev = "master";
    hash = "sha256-77w+8eEQOaXYCN/SZYaSH928bHox4DJS1Z00aD5xvHQ=";
  };

  zsh-themes = pkgs.stdenv.mkDerivation {
    name = "oh-my-custom-zsh-theme";
    phases = ["buildPhase"];
    buildPhase = ''
      mkdir -p $out/themes
      cp ${ikostov-zsh-themes}/themes/*.zsh-theme  $out/themes/
    '';
  };
in {
  options.modules.zsh = {
    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable zsh shell
      '';
    };

    env-vars = mkOption {
      type = attrsOf str;
      default = {};
      description = mkDoc ''
        Additional env-vars
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = false;
      autocd = true;
      cdpath = [
        ''
          ~/Downloads
          /etc/nixos
        ''
      ];
      history.size = 10000;
      oh-my-zsh = {
        enable = true;
        theme = "af-purple-magic";
        custom = "${zsh-themes}";
        plugins = [
          ''
            ssh-agent
            direnv
            vi-mode
          ''
        ];
      };
      shellAliases = {
        py = "python3";
        uy = "uv run";
        pip3 = "uv pip";
        venv = "source .venv/bin/activate";
        dvenv = "source .devenv/state/venv/bin/activate";

        pip-lock = "uv pip compile pyproject.toml -o requirements.txt";
        pip-sync = "uv pip sync requirements.txt";
        pip-sync-toml = "uv pip sync pyproject.toml";

        # venv = "eval $(pdm venv activate)";
        pdm-sync = "pdm install && pdm sync --clean";
        pdm-export = "pdm export -o requirements.txt";
        uv-export = "uv pip compile pyproject.toml -o requirements.txt";

        # Maven
        mvn-jar = "mvn -f pom.xml clean package";
        mvn-cc-jar = "mvn -s ~/.m2/cc-settings.xml -f pom.xml clean package";
        mvn-spring = "mvn spring-boot:run";
        mvn-deps = "mvn dependency:resolve";
        mvn-deps-tree = "mvn dependency:tree";
        mvn-run = "mvn compile exec:java";

        # Infra
        tf = "terraform";
        dc = "docker";
        dcc = "docker compose";
        kc = "kubectl";

        # Utils
        gitroot = "cd $(git root)";
        gitunstage = "git restore --staged";
        gitig = "git-ignore";
        clip = "xclip -selection clipboard";
        ls = "eza";
        cat = "bat";
        base = "basename $(pwd)";
      };
      # initContent = builtins.readFile /home/nixos/Documents/.bashrc;
    };

    programs.direnv = {
      enable = true;
      silent = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
