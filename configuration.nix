# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;

  boot.extraModulePackages = [ config.boot.kernelPackages.exfat-nofuse ];

  # Define hostname.
  networking.hostName = "kumail-nix";

  # Enable DHCP.
  networking.interfaces.enp34s0.useDHCP = true;

  # Enable NetworkManager
  networking.networkmanager.enable = true;

  # Enable Bluetooth.
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
	
  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [
    elvish
  ];

  # Install fonts system-wide
  fonts.fonts = with pkgs; [
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable dbus gnome
  services.dbus.packages = with pkgs; [
    gnome3.dconf
  ];

  # Enable gvfs for automounting
  services.gvfs.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  hardware.pulseaudio.support32Bit = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";
  services.xserver.videoDrivers = [ "nvidia" ];

  services.xserver.displayManager.session = [
    {
      manage = "desktop";
      name = "xsession";
      start = "";
    }
  ];
  services.xserver.displayManager.lightdm.greeters.mini = {
    enable = true;
    user = "kumail";
    extraConfig = ''
      [greeter]
      show-password-label = false
      [greeter-theme]
      background-image = "/etc/lightdm/background.jpg"
      window-color = "#D33682"
      layout-space = 5
      border-width = 1px
    '';
  };

  # Enable support for 32-bit OpenGL DRI
  hardware.opengl.driSupport32Bit = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kumail = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user, and access to wifi configuration.
     shell = pkgs.elvish;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

}

