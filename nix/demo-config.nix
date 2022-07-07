# =====================================
# === DEMO CONFIG THAT USES MY DOTS ===
# =====================================

# === CONFIGURATION VARS ===
{ config, pkgs, ... }:

{
  # === IMPORTS ===
  imports = [
    ./hardware-configuration.nix
    /home/whatever/nixDots/nix/other-options.nix
  ];

  # === HOSTNAME ===
  networking.hostName = "LapyZapy";
  networking.networkmanager.enable = true;

  # === USERS ===
  users.users.whatever = {
    isNormalUser = true;
    description = "My main user";
    extraGroups = [ "networkmanager" ];
    packages = with pkgs; [];
  };
  users.users.root.shell = "/run/current-system/sw/bin/nologin";
  users.defaultUserShell = pkgs.fish;

  # === SOFTWARE ===
  # software packadges
  environment.systemPackages = with pkgs; [
	neovim
	fish
	btop
	doas
	git
	hyprland
	wget
  ];

  # === MY CONFGS ===
  system.activationScripts = {
    dotfiles = {
      text = ''
      ln -sf /home/whatever/nixDots/shell/fish /home/whatever/.config/
      ln -sf /home/whatever/nixDots/shell/btop /home/whatever/.config/
      '';
      deps = [];
    };
  };
}
