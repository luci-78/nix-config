{ inputs, config, lib, pkgs, ... }:

{
  hm.imports = [ inputs.catppuccin.homeModules.catppuccin ];
  hm.catppuccin = {
    enable = true;
    autoEnable = true;
    qt5ct.enable = true;
    cache.enable = true;
    flavor = "mocha";
    accent = "mauve";
  };

  hm.gtk = {
    enable = true;
    theme = {
      package = lib.mkForce pkgs.magnetic-catppuccin-gtk;
      name = lib.mkForce "Catppuccin-GTK-Dark";
    };
    gtk4.theme = config.hm.gtk.theme;
  };
}
