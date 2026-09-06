{ config, pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    qemu.package = pkgs.qemu_kvm;
    # OVMF (UEFI firmware for guests) ships with qemu by default now —
    # the old virtualisation.libvirtd.qemu.ovmf submodule was removed.
  };

  # USB passthrough into VMs from virt-manager's Redirect USB Device menu
  virtualisation.spiceUSBRedirection.enable = true;

  programs.virt-manager.enable = true;

  # Needed for the default libvirt NAT network's DHCP/DNS
  environment.systemPackages = with pkgs; [
    qemu
    virt-viewer
    dnsmasq
    virtio-win # virtio driver ISO, for installing Windows guests with virtio disk/net
  ];

  users.groups.libvirtd.members = [ "querzion" ];
}
