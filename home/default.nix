{
  stateVersion,
  lib,
  user,
  ...
}: let
  username = user;
in {
  imports = (
    if builtins.pathExists ./${username}
    then [./${username}]
    else
      lib.warn
      "> User: ${username} DOESN'T have home directory under ./home! Defaulting to NONE... "
      []
  );

  home = {
    homeDirectory = "/home/${username}";
    inherit username stateVersion;
  };

  nixpkgs.config.allowUnfree = true;
  news.display = "silent";
  programs.home-manager.enable = true;
}
