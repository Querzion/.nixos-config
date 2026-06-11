{ config, pkgs, ... }:

{
  services.printing.enable = false;

  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
  };

  # Keyboard layout - Swedish Dvorak
  services.xserver.xkb = {
    layout  = "se";
    variant = "dvorak";
  };

  # Console keymap
  console.keyMap = "sv-latin1";

  # Touchpad support (libinput)
  services.xserver.libinput.enable = true;

  security.rtkit.enable = true;
}
