{ pkgs, lib, ... }:

{
  hm.programs.yazi = {
    enable = true;
    shellWrapperName = "yy";
    plugins = with pkgs.yaziPlugins; { inherit smart-filter wl-clipboard ouch; };
    keymap.mgr.prepend_keymap = lib.mapAttrsToList (k: v: { on = k; run = v; }) {
      "F" = "plugin smart-filter";
      "C" = "plugin ouch";
      "<C-y>" = "plugin wl-clipboard";
      "b" = ''shell -- ${lib.getExe pkgs.ripdrag} --and-exit --no-click --all-compact %s'';
    };
    settings = {
      plugin.prepend_previewers = builtins.map (n: { mime = "application/${n}"; run = "ouch"; })
        [ "*zip" "x-tar" "x-bzip2" "x-7z-compressed" "x-rar" "vnd.rar" "x-xz" "xz" "x-zstd" "zstd" "java-archive" ];
      opener.extract = [{ run = ''
        for file in %s; do
          ${lib.getExe pkgs.ouch} decompress "$file" --yes &
        done
        wait
      '';}];
    };
  };
}
