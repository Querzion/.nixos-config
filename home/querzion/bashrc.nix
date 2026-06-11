{ pkgs, ... }:

{
  programs.bash = {
    enable = true;
    initExtra = ''
      # --------------------------
      # System Information
      # --------------------------
      fastfetch

      # --------------------------
      # Environment variables
      # --------------------------
      export NIXOS_DOTFILES="~/.nixos-config"
      export NIXOS_HOST="querzion"
      export DOTNET_ROOT="${pkgs.dotnet-sdk_8}"
      export PATH="$PATH:$HOME/.dotnet/tools"

      # --------------------------
      # NixOS Flake management
      # --------------------------
      alias nos-niri='cd ~/.nixos-config && sudo nixos-rebuild switch --flake .#thinkpad-niri'
      alias nos-plasma='cd ~/.nixos-config && sudo nixos-rebuild switch --flake .#thinkpad-plasma'
      alias nos-gnome='cd ~/.nixos-config && sudo nixos-rebuild switch --flake .#thinkpad-gnome'
      alias nos-cosmic='cd ~/.nixos-config && sudo nixos-rebuild switch --flake .#thinkpad-cosmic'
      alias nos-xfce='cd ~/.nixos-config && sudo nixos-rebuild switch --flake .#thinkpad-xfce'
      alias nos-update='cd ~/.nixos-config && nix flake update'
      alias nos-check='cd ~/.nixos-config && nixos-rebuild build --flake .#thinkpad-niri'

      # --------------------------
      # Home Manager
      # --------------------------
      alias hm-switch='cd ~/.nixos-config && home-manager switch --flake .#slisk'

      # --------------------------
      # Git shortcuts
      # --------------------------
      alias gs='git status'
      alias ga='git add'
      alias gc='git commit -v'
      alias gcm='git commit -m'
      alias gp='git push'
      alias gl='git pull --rebase'
      alias gco='git checkout'
      alias gbr='git branch'
      alias gdf='git diff'
      alias gen-gh-key='ssh-keygen -t rsa -b 4096 -C "slisk.lindqvist@querzion.com" -f ~/.ssh/id_rsa_github'
      alias lazy-qc='cd ~/.nixos-config && git add . && git commit -F <(git status -s) && git push'

      # --------------------------
      # Docker shortcuts
      # --------------------------
      alias dps='docker ps'
      alias dpa='docker ps -a'
      alias dstop='docker stop'
      alias drm='docker rm'
      alias drmi='docker rmi'
      alias dbuild='docker build -t'
      alias dexec='docker exec -it'

      # --------------------------
      # .NET EF
      # --------------------------
      alias ef-update='
        dotnet tool install --global dotnet-ef || dotnet tool update --global dotnet-ef
        echo "dotnet-ef version: $(dotnet-ef --version)"
      '

      # --------------------------
      # Mailspring (non-KDE/GNOME sessions)
      # --------------------------
      alias mailspring='mailspring --password-store="gnome-libsecret"'

      # --------------------------
      # General
      # --------------------------
      alias ls='ls --color=auto -hF'
      alias ll='ls -lah --color=auto'
      alias grep='grep --color=auto'
      alias df='df -h'
      alias du='du -h'
      alias cls='clear'

      # --------------------------
      # Starship prompt
      # --------------------------
      eval "$(starship init bash)"
    '';
  };
}
