_: {
  users = {
    nixos = {
      isNormalUser = true;
      createHome = true;
      description = "Nixos profile";
      extraGroups = ["wheel" "docker"];
    };
  };
}
