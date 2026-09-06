{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    spotify
    qpwgraph
  ];
}
