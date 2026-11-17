local function launch_bind(command)
    return hl.dsp.exec_cmd("uwsm app -- " .. command)
end

hl.bind("SUPER + Q", launch_bind "kitty")
hl.bind("SUPER + E", launch_bind "kitty -e yazi")
hl.bind("SUPER + SUPER_L", hl.dsp.exec_cmd("hyprlauncher"), { release = true })
hl.bind("SUPER + SHIFT + S", launch_bind "hyprshot -m region --clipboard-only --silent --freeze")
-- TODO: cliphist SUPER + V
-- TODO: stt SUPER + R

hl.bind("SUPER + C", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + C", hl.dsp.window.kill())

hl.bind("SUPER + M", hl.dsp.exec_cmd("uwsm stop"))

hl.bind("SUPER + J", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.float { mode = "toggle" })
hl.bind("SUPER + SHIFT + P", hl.dsp.window.pin { mode = "toggle"})
hl.bind("SUPER + F", hl.dsp.window.fullscreen { action = "toggle" })
hl.bind("SUPER + SHIFT + L", hl.dsp.dpms { action = "toggle" })

local dirs = { "left", "right", "up", "down" }
for i = 1, #dirs do
    hl.bind("SUPER + " .. dirs[i],  hl.dsp.focus({ direction = dirs[i] }))
end

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + ALT + mouse:272", hl.dsp.window.resize(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
