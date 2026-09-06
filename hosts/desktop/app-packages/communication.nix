{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    discord
    teams-for-linux
    brave
    firefox
    thunderbird
  ];
}
