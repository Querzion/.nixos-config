{ config, pkgs, ... }:

{
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

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_SCALING_GOVERNOR_ON_AC  = "performance";
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0  = 80;
      PCIE_ASPM_ON_BAT = "powersupersave";
      DISK_APM_LEVEL_ON_BAT = "128";
      WIFI_PWR_ON_BAT = "on";
      WIFI_PWR_ON_AC  = "off";
      RUNTIME_PM_ON_BAT = "auto";
      RUNTIME_PM_ON_AC  = "on";
    };
  };

  services.thermald.enable = true;
  powerManagement.enable = true;
  services.power-profiles-daemon.enable = false;

  environment.systemPackages = with pkgs; [
    powertop
  ];
}
