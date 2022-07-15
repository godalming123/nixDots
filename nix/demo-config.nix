# ======================================
# === A DEMO CONFIG TO SETUP MY DOTS ===
# ======================================

# === CONFIGURATION VARS ===
{ config, pkgs, ... }:

{
  # === IMPORTS ===
  imports = [
    ./hardware-configuration.nix
    /home/whatever/nixDots/nix/other-options.nix
  ];

  # === NETWORKING ===
  networking = {
    hostName = "LapyZapy";
    networkmanager.enable = true;
  };

  # === USERS ===
  users.users.whatever = {
    isNormalUser = true;
    description = "My main user";
    extraGroups = [ "networkmanager" "audio" "docker" "video"];
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
	gh
	hyprland
	wget
	pfetch
	firefox-wayland
	#kitty
	alacritty
	swaylock
	killall
	light
	waybar
	wofi
	pamixer
  ];

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = false;
  };

  #fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  # === MY CONFGS ===
  system.activationScripts = {
    dotfiles = {
      text = ''
      ln -sf /home/whatever/nixDots/shell/fish /home/whatever/.config/
      ln -sf /home/whatever/nixDots/shell/btop /home/whatever/.config/
      ln -sf /home/whatever/nixDots/DE/hypr/   /home/whatever/.config/
      ln -sf /home/whatever/nixDots/shell/nvim /home/whatever/.config/
      ln -sf /home/whatever/nixDots/DE/wofi/   /home/whatever/.config/
      '';
      deps = [];
    };
  };
}
