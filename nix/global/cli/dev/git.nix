{ ... }:

{
  programs.git = {
    enable = true;
    config = {
      color.ui = true;
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      submodule.recurse = true;
      core.editor = "micro";
      user = {
        name = "luci";
        email = "310865338+luci-78@users.noreply.github.com";
      };
      github.user = "luci-78";
    };
  };
}
