# ===============================
# === GODALMINGS NIXOS CONFIG ===
# ===============================

# === CONFIGURATION VARS ===
{ config, pkgs, ... }: let
  flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
  hyprland = (import flake-compat {
    src = builtins.fetchTarball "https://github.com/hyprwm/Hyprland/archive/master.tar.gz";
  }).defaultNix;
in {
  nixpkgs.overlays = [ hyprland.overlays.default ];

  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
  };
  
  # === IMPORTS ===
  imports = [
    ./hardware-configuration.nix
    /home/whatever/nixDots/nix/other-options.nix
    hyprland.nixosModules.default
  ];

  # === BLUETOOTH ===
  hardware.bluetooth.enable = true;

  # === NETWORKING ===
  networking = {
    hostName = "LapyZapy";
    networkmanager.enable = true;
  };

  # flakes
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # === USERS ===
  users.users.whatever = {
    isNormalUser = true;
    description = "My main user";
    extraGroups = [ "networkmanager" "audio" "video" "input"];
    packages = with pkgs; [];
  };
  users.users.root.shell = "/run/current-system/sw/bin/nologin";
  users.defaultUserShell = pkgs.fish;

  # === SOFTWARE ===
  # software packadges
  environment.systemPackages = with pkgs; [
        # = SHELL SOFTWARE =
				neovim
				fish
				btop
				doas
				git
				gh
				wget
				pfetch
				killall
				light
				tldr
				wl-clipboard
				pamixer
				trash-cli
				#wine-wayland
				# = GUI SOFTWARE =
				#hyprland
				gnome.nautilus
				firefox-wayland
				alacritty
				swaylock
				waybar
				wofi
				# = DEPENDENCYS =
				gnome3.adwaita-icon-theme
				libinput
				# for neovim
				universal-ctags
				nodePackages.pyright # lsp for python
				nodePackages.vscode-langservers-extracted # lsp servers for html css json and eslint
				sumneko-lua-language-server # lsp for lua
				gopls # lsp for go
				nodePackages.firebase-tools # firebase command line tools
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
      ln -sf /home/whatever/nixDots/shell/fish               /home/whatever/.config/
      ln -sf /home/whatever/nixDots/shell/btop               /home/whatever/.config/
      ln -sf /home/whatever/nixDots/DE/hypr/                 /home/whatever/.config/
      ln -sf /home/whatever/nixDots/shell/nvim               /home/whatever/.config/
      ln -sf /home/whatever/nixDots/DE/wofi/                 /home/whatever/.config/
      #ln -sf /home/whatever/nixDots/DE/waybar/               /home/whatever/.config/
      ln -sf /home/whatever/nixDots/basicPrograms/alacritty/ /home/whatever/.config/
      '';
      deps = [];
    };
  };
}
