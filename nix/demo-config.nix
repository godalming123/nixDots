# =========================
# === DEMO NIXOS CONFIG ===
# =========================

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

  
  # flakes
  #nix = {
  #  package = pkgs.nixUnstable; # or versioned attributes like nixVersions.nix_2_8
  #  extraOptions = ''
  #    experimental-features = nix-command flakes
  #  '';
  #};

  # === USERS ===
  users.users.whatever = {
    isNormalUser = true;
    description = "My main user";
    extraGroups = [ "networkmanager" "audio" "video"];
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
	gnome3.adwaita-icon-theme
	universal-ctags
	nodePackages.pyright
	wl-clipboard
	tldr
  ];

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = false;
    #desktopManager.gnome.enable = true;
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
      ln -sf /home/whatever/nixDots/DE/waybar/ /home/whatever/.config/
      '';
      deps = [];
    };
  };
}
