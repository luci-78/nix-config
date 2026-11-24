require "conf/appearance"
require "conf/binds"
require "conf/window-rules"
local host <const> = os.getenv("HYPR_HOST")
if host then require("host/" .. host) end

local function launch(command)
    return hl.exec_cmd("uwsm app -- " .. command)
end
hl.on("hyprland.start", function ()
    launch "swaybg --mode fill --image ~/nix-config/assets/wallpaper.svg"
    launch "hyprlauncher -d"
end)
