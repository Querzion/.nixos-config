{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user = {
        name = "Slisk Lindqvist";
        email = "slisk.lindqvist@querzion.com";
      };
      pull.rebase = false;
      credential.helper = "store";
    };
  };
}
