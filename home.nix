{
  pkgs,
  config,
  lib,
  ...
}: {
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;

    users.nixos = {pkgs, ...}: let
      tmux-conf =
        lib.fileContents ./tmux.conf;
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
    in {
      programs.git.enable = true;
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
              direnv
              vi-mode
            ''
          ];
        };
        shellAliases = {
          py = "python3";
          uy = "uv run";
          pip = "uv pip";
          venv = "source .venv/bin/activate";

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
        initExtra = ''
          bindkey -M vicmd 'V' edit-command-line
        '';
      };

      programs.direnv = {
        enable = true;
        silent = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };

      programs.neovim = {
        enable = true;
        vimAlias = true;
        defaultEditor = lib.mkForce true;
        extraPackages = with pkgs; [yamllint nodejs_22 unzip];
      };

      programs.tmux = {
        enable = true;
        plugins = with pkgs.tmuxPlugins; [
          resurrect
          sensible
          yank
          open
        ];
        extraConfig = tmux-conf;
        clock24 = true;
        baseIndex = 1;
        mouse = true;
      };

      home.packages = with pkgs; [
        kubectl
        kubernetes-helm
        kind
        docker
        eza
        bat
        htop
        awscli2
        git-all
        git-rm-local-brv
        fzf
      ];

      home.stateVersion = "24.11";
    };
  };
}
