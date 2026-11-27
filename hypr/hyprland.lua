require "conf/appearance"
require "conf/binds"
require "conf/window-rules"
local host <const> = os.getenv("HOSTNAME")
if host then require("host/" .. host) end

---@param slice "b"|"a"|"s" - priority for CPU/RW/RAM - b: bkg, a: app, s: session
local function launch(slice, command)
    return hl.exec_cmd("uwsm app -s " .. slice .. " -- " .. command)
end
hl.on("hyprland.start", function ()
    launch("s", "swaybg --mode fill --image ~/nix-config/assets/wallpaper.svg")
    launch("s", "hyprlauncher -d")
end)
