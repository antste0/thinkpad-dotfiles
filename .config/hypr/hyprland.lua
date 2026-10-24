-- Converted from hyprlang (hyprland.conf) to the Lua config
-- introduced in Hyprland 0.55.
-- Refer to: https://wiki.hypr.land/Configuring/Start/

local colors = require("themes/rose-pine")

------------------
---- MONITORS ----
------------------
-- monitor=,preferred,1920x1080,1
hl.monitor({
    output   = "",
    mode     = "preferred",
    --position = "1920x1080",
    scale    = 1,
})

-- monitor=DP-4,preferred,0x0,1,mirror,eDP-1
hl.monitor({
    output   = "DP-4",
    mode     = "preferred",
    position = "0x0",
    scale    = 1,
    mirror   = "eDP-1",
})

---------------------
---- MY PROGRAMS ----
---------------------
local terminal    = "kitty"
local fileManager  = "thunar"
local menu         = "wofi -modi drun, run --show drun"

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XCURSOR_SIZE", "20")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("WLR_DRM_NO_ATOMIC", "1")

---------------
---- INPUT ----
---------------
hl.config({
    input = {
        kb_layout  = "pl",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        touchpad = {
            disable_while_typing = false,
            natural_scroll = true,
        },

        sensitivity = 0,
    },
})

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in    = 5,
        gaps_out   = 15,
        border_size = 2,
        col = {
            active_border = { colors = { colors.rose, colors.surface, colors.foam }, angle = 45 },
            inactive_border = "rgba(7c6f64aa)",
        },

        layout = "dwindle",

        allow_tearing = false,
    },

    decoration = {
        rounding = 5,

        blur = {
            enabled = true,
            size    = 3,
            passes  = 1,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Bezier curves + animation leaves
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

hl.animation({ leaf = "windows",    enabled = true, speed = 3, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",     enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "borderangle",enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade",       enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "default" })

hl.config({
    dwindle = {
        preserve_split = true, -- you probably want this
    },
    master = {
    },
})

-- Example per-device config
hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
hl.window_rule({
    name = "nomaximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"

hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- dwindle

hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resize active window with keyboard (confirmed via Hyprland forum:
-- relative = true is required, otherwise x/y are treated as an absolute
-- size instead of a delta)
hl.bind(mainMod .. " + SHIFT + h",     hl.dsp.window.resize({ x = -40, y = 0,   relative = true }))
hl.bind(mainMod .. " + SHIFT + l",     hl.dsp.window.resize({ x = 40,  y = 0,   relative = true }))
hl.bind(mainMod .. " + SHIFT + k",     hl.dsp.window.resize({ x = 0,   y = -40, relative = true }))
hl.bind(mainMod .. " + SHIFT + j",     hl.dsp.window.resize({ x = 0,   y = 40,  relative = true }))
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -40, y = 0,   relative = true }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 40,  y = 0,   relative = true }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0,   y = -40, relative = true }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0,   y = 40,  relative = true }))

-- Media keys
-- locked -> works even when the session is locked
-- repeating -> repeats while the key is held
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("set-sink-volume @DEFAULT_SINK@ +4%"), { locked = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("vol --down"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("bri --up"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("bri --down"), { locked = true, repeating = true })
hl.bind("XF86Search",            hl.dsp.exec_cmd("launchpad"),  { locked = true, repeating = true })
-- hl.bind("XF86AudioMute", hl.dsp.exec_cmd("amixer set Master toggle"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"),     { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Screenshot of a region
hl.bind("PRINT", hl.dsp.exec_cmd(
    "sh -c 'REGION=$(slurp) || exit; grim -g \"$REGION\" - | wl-copy && " ..
    "wl-paste > ~/Pictures/screenshots/Screenshot-$(date +%F_%T).png && " ..
    "dunstify \"Screenshot of the region taken\" -t 1000'"
))

-- Screenshot of an entire screen
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("grim $(xdg-user-dir PICTURES)/screenshots/$(date +'%s.png')"))

-- Set keyboard brightness to 50%
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("brightnessctl --device='tpacpi::kbd_backlight' set 1"))

-- Fullscreen (confirmed via GitHub discussion #14494: needs explicit
-- mode/action, a bare fullscreen() call doesn't toggle correctly)
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }), { description = "Toggle Fullscreen" })

-- hyprlock
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaybg -i ~/Pictures/wallpapers/rose_pine_contourline.png")

    -- Polkit for root privilege
    hl.exec_cmd("/usr/bin/lxqt-policykit-agent")

    -- obs
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)
