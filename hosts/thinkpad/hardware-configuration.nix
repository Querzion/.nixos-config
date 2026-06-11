{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/mapper/luks-812ad394-5d0b-40a3-8cd4-4a04a667cae9";
    fsType = "btrfs";
  };

  boot.initrd.luks.devices."luks-812ad394-5d0b-40a3-8cd4-4a04a667cae9".device =
    "/dev/disk/by-uuid/812ad394-5d0b-40a3-8cd4-4a04a667cae9";

  fileSystems."/home" = {
    device = "/dev/mapper/luks-812ad394-5d0b-40a3-8cd4-4a04a667cae9";
    fsType = "btrfs";
    options = [ "subvol=home" ];
  };

  fileSystems."/nix" = {
    device = "/dev/mapper/luks-812ad394-5d0b-40a3-8cd4-4a04a667cae9";
    fsType = "btrfs";
    options = [ "subvol=nix" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/C0A0-74F9";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [
    { device = "/dev/mapper/luks-3664dc81-03ca-4a22-b927-b2f8dfd052e2"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
