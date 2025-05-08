{pkgs, ...}: {
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;

    users.nixos = {pkgs, ...}: {
      programs.git.enable = true;
      programs.zsh.enable = true;

      home.packages = with pkgs; [
        htop
        fd
        jq
      ];

      home.stateVersion = "24.11";
    };
  };
}
