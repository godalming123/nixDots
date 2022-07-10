# ============================================
# === MISCELANIOS OPTIONS IN MY NIX CONFIG ===
# ============================================

# === CONFIGURATION VARS ===
{ config, pkgs, ... }:

{
  # === BOOTLOADER ===
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # === TIME ZONE ===
  time.timeZone = "Europe/London";

  # === KEYBOARD LAYOUT ===
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.supportedLocales = [
    "en_GB.UTF-8/UTF-8"
  ];

  services.xserver = {
    layout = "gb";
    xkbVariant = "";
  };

  console.keyMap = "uk";
  
  # === SOFTWARE ===
  # sources
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "22.05";
  system.autoUpgrade.enable = true;

  # flakes
  #nix = {
  #  package = pkgs.nixUnstable; # or versioned attributes like nixVersions.nix_2_8
  #  extraOptions = ''
  #    experimental-features = nix-command flakes
  #  '';
  #};
  
  # software configs
  programs.fish.enable = true;
  #virtualisation.docker.enable = true;
  security.doas = {
    enable = true;
    extraRules = [{
      users = ["whatev" "whatever"];
      keepEnv = true;
      persist = true;
    }];
  };

  # disable some programs
  security.sudo.enable = false;
  #programs.bash.enable = false;

  # === SERVICES ===
  services = {
    auto-cpufreq.enable = true;
    tlp.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  # === AUTOMATIC REMOVAL OF OLD GENERATIONS ===
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 1d";
  };
}
