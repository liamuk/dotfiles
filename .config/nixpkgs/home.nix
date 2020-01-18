{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # The Home Manager release that this configuration is compatible with.
  home.stateVersion = "19.09";

  # The .xsession config.
  xsession.enable = true;
  xsession.windowManager.command = "${pkgs.bspwm}/bin/bspwm -c ${config.xdg.configHome}/bspwm/bspwmrc";

  services.compton.enable = true;

  gtk.enable = true;  
  gtk.iconTheme = {
    package = pkgs.paper-icon-theme;
    name = "Paper";
  };
  gtk.gtk3.extraConfig = {
    gtk-cursor-theme-name = "Vanilla-DMZ";
    gtk-cursor-theme-size = 11;
  };
}
