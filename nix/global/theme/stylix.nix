{ inputs, lib, pkgs, ... }:

{
  imports = [ inputs.stylix.nixosModules.stylix ];
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    cursor = {
      name = "Posy_Cursor";
      package = pkgs.posy-cursors;
      size = 32;
    };

    fonts = let nunito = { package = pkgs.nunito; name = "Nunito"; }; in {
      serif = nunito;
      sansSerif = nunito;
      # TODO: customize Nunito
      monospace = { package = pkgs.iosevka-bin; name = "Iosevka"; };
      emoji = { package = pkgs.twitter-color-emoji; name = "Twitter Color Emoji"; };
    };

  };
  # catppuccin's flake does better on stuff it covers
  hm.stylix.targets =
    lib.genAttrs ([
      "gtk"
    ]) (name: { enable = false; })
    // lib.genAttrs ([
      "yazi" "btop"
    ]) (name: { colors.enable = false; });
}
