{ pkgs, baseVars, ... }:

{
  environment.systemPackages = [ (
    (pkgs.discord.override (old: {
      withEquicord = true;
      withTTS = false;
      enableAutoscroll = true;
      useFHSEnv = false;
    })).overrideAttrs (old: {
      # force use of impure equicord install's patcher to get faster updates
      postInstall = (old.postInstall or "") + ''
        echo 'require ("/home/${baseVars.username}/misc/equicord/dist/desktop/patcher.js")' > $out/opt/Discord/resources/app.asar/index.js
      '';
    })
  ) ];
}
