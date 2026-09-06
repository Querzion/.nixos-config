{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    keepassxc
    libsecret
  ];

  security.rtkit.enable = true;
}
