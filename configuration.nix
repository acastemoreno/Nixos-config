# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  boot.loader.grub.extraEntries = ''
  menuentry "Windows 7" {
    chainloader (hd0,1)+1
  }
  '';

  # networking.hostName = "nixos"; # Define your hostname.
  networking.hostId = "52a032cb";
  # networking.wireless.enable = true;  # Enables wireless.

  # Select internationalisation properties.
   i18n = {
     consoleFont = "lat9w-16";
     consoleKeyMap = "es";
     defaultLocale = "es_PE.UTF-8";
   };

  time.timeZone = "America/Lima";
   
  services.almir.timezone = "America/Latina";
  nixpkgs.config = {

    allowUnfree = true;
    
    firefox = {
     enableGoogleTalkPlugin = true;
     enableAdobeFlash = true;
    };
        
    chromium = {
     enablePepperFlash = true; # Chromium removed support for Mozilla (NPAPI) plugins so Adobe Flash no longer works 
     enablePepperPDF = true;
    };

  };
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

   
   environment.systemPackages = with pkgs; [
     wget
     vim
     git
     zsh
     vlc
     emacs
     alsaLib
     alsaPlugins
     alsaUtils
     kde4.kdemultimedia
     libreoffice
     leiningen
     clojure
     jre
     chromium
     firefoxWrapper
     cups
     gutenprint   
     gutenprintBin
     blender
  ];

  services.printing = {
      enable = true;
      drivers = [ pkgs.gutenprint ];
    };

  programs.zsh.enable = true;

  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  #services.xserver.displayManager.kdm.enable = true;
  services.xserver.desktopManager.kde4.enable = true;
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.albert = {
    isNormalUser = true;
    home = "/home/albert";
    };

}
