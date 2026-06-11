{ config, pkgs, ... }:

{
  # auto-cpufreq: intelligent CPU frequency scaling
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "auto";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  # TLP: advanced power management for ThinkPads
  services.tlp = {
    enable = true;
    settings = {
      # CPU scaling
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_SCALING_GOVERNOR_ON_AC  = "performance";

      # ThinkPad charge thresholds (keeps battery healthy)
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0  = 80;

      # PCIe power management
      PCIE_ASPM_ON_BAT = "powersupersave";

      # Disk power management
      DISK_APM_LEVEL_ON_BAT = "128";

      # WiFi power saving
      WIFI_PWR_ON_BAT = "on";
      WIFI_PWR_ON_AC  = "off";

      # Runtime power management
      RUNTIME_PM_ON_BAT = "auto";
      RUNTIME_PM_ON_AC  = "on";
    };
  };

  # Thermal management
  services.thermald.enable = true;

  # Power management base
  powerManagement.enable = true;

  # powertop for diagnostics
  environment.systemPackages = with pkgs; [
    powertop
  ];
}
