{ config, pkgs, ... }:

{
  users.users.querzion = {
    isNormalUser = true;
    description  = "Slisk Lindqvist";
    extraGroups  = [ "networkmanager" "wheel" "bluetooth" "input" "docker" ];
    shell        = pkgs.bash;
  };
}
