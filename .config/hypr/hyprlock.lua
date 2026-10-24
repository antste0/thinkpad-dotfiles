-- NOTE: hyprlock (the standalone lock-screen binary) has its own config
-- parser and does NOT support the Lua config system that Hyprland 0.55+
-- added for hyprland.conf. There is no `hyprlock.lua` that hyprlock itself
-- will load -- keep using hyprlock.conf for the real config.
--
-- This file only exists as a Lua *data* representation of that same
-- config, in case you want to generate hyprlock.conf from it (e.g. with a
-- small script) or reuse the values elsewhere in your dotfiles.

local colors = require("themes/rose-pine")

return {
    source = "./themes/rose-pine.conf",
    font   = "Noto Sans",

    general = {
        hide_cursor = false,
    },

    -- auth = {
    --     fingerprint = {
    --         enabled = true,
    --         ready_message = "Scan fingerprint to unlock",
    --         present_message = "Scanning...",
    --         retry_delay = 250, -- ms
    --     },
    -- },

    animations = {
        enabled = true,
        curve = { name = "linear", points = { {1, 1}, {0, 0} } },
        leaves = {
            { leaf = "fadeIn",         speed = 3, bezier = "linear" },
            { leaf = "fadeOut",        speed = 3, bezier = "linear" },
            { leaf = "inputFieldDots", speed = 2, bezier = "linear" },
        },
    },

    background = {
        monitor      = "",
        path         = "screenshot",
        blur_passes  = 1,
    },

    input_field = {
        monitor            = "",
        size               = "20%, 5%",
        outline_thickness  = 3,
        inner_color        = "rgba(0, 0, 0, 0.0)", -- no fill

        outer_color = { colors = { colors.pine, colors.iris }, angle = 20 },
        check_color = { colors = { colors.pine }, angle = 120 },
        fail_color  = { colors = { colors.love, colors.pine }, angle = 40 },

        font_color    = colors.text,
        fade_on_empty = false,
        rounding      = 12,

        font_family       = "$font",
        placeholder_text  = "Input password...",
        fail_text         = "$PAMFAIL",

        -- dots_text_format = "*",
        -- dots_size = 0.4,
        dots_spacing = 0.3,

        -- hide_input = true,

        position = { -0, -20 }, -- x, y
        halign   = "center",
        valign   = "center",
    },

    labels = {
        -- TIME
        {
            monitor     = "",
            text        = "$TIME",
            font_size   = 90,
            font_family = "$font",
            position    = { -30, 0 },
            halign      = "right",
            valign      = "top",
        },
        -- DATE
        {
            monitor     = "",
            text        = 'cmd[update:60000] date +"%A, %d %B %Y"', -- refresh every 60s
            font_size   = 25,
            font_family = "$font",
            font_color  = colors.text,
            position    = { -30, -150 },
            halign      = "right",
            valign      = "top",
        },
        -- keyboard layout indicator (disabled in source)
        -- {
        --     monitor = "",
        --     text = "$LAYOUT[en,ru]",
        --     font_size = 24,
        --     onclick = "hyprctl switchxkblayout all next",
        --     position = { 250, -20 },
        --     halign = "center",
        --     valign = "center",
        -- },
    },
}
