-- ########################################################################################################
-- # Monitors                                                                                             #
-- ########################################################################################################
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "DP-1",
    mode     = "5120x2880@60.00000",
    position = "auto",
    scale    = "1",
    cm       = "dp3"
})

-- ########################################################################################################
-- # Programs                                                                                             #
-- ########################################################################################################
local terminal    = "kitty"
local fileManager = "nautilus"
local menu        = "vicinae toggle"

-- ########################################################################################################
-- # Autostar                                                                                             #
-- ########################################################################################################
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    --hl.exec_cmd("waybar & hyprpaper & firefox")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waybar")
    hl.exec_cmd("vicinae server")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("mako")
end)

-- ########################################################################################################
-- # Env                                                                                                  #
-- ########################################################################################################
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE", "32")
hl.env("HYPRCURSOR_SIZE", "32")

-- ########################################################################################################
-- # Permissions                                                                                          #
-- ########################################################################################################
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons
-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })
-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-- ########################################################################################################
-- # Look                                                                                                 #
-- ########################################################################################################
-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in          = 5,
        gaps_out         = 20,
        border_size      = 2,
        col              = {
            active_border = "#51afef",
            inactive_border = "#3d4451",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing    = false,

        layout           = "dwindle",
    },
    decoration = {
        rounding         = 8,
        rounding_power   = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow           = {
            enabled      = true,
            range        = 15,
            render_power = 3,
            color        = "rgba(0, 0, 0, 0.50)",
        },

        blur             = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- ########################################################################################################
-- # Look                                                                                                 #
-- ########################################################################################################
-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})
-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})
-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

-- ########################################################################################################
-- # Misc                                                                                                 #
-- ########################################################################################################
hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})

-- ########################################################################################################
-- # Input                                                                                                #
-- ########################################################################################################
hl.config({
    input = {
        kb_layout      = "us(intl)",
        repeat_rate    = 35,
        repeat_delay   = 500,

        follow_mouse   = false,
        accel_profile  = "flat",
        sensitivity    = 0.0, -- -1.0 - 1.0, 0 means no modification.
        force_no_accel = false,
        --no_hardware_cursors = false,
    },
})

-- ########################################################################################################
-- # Key Bindings                                                                                         #
-- ########################################################################################################
local main = "SUPER" -- Sets "Windows" key as main mainifier
local quit = "command -v hyprshutdown > /dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
local lock = "hyprlock"
local screenshot = "QT_ENABLE_HIGHDPI_SCALING=0 flameshot gui"

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
-- Application
hl.bind(main .. " + Space", hl.dsp.exec_cmd(menu))
hl.bind(main .. " + T", hl.dsp.exec_cmd(terminal))

-- Hyprland action
hl.bind(main .. " + SHIFT + E", hl.dsp.exec_cmd(quit))
hl.bind("CONTROL + ALT + DELETE", hl.dsp.exec_cmd(quit))
hl.bind(main .. " + L", hl.dsp.exec_cmd(lock))
hl.bind(main .. "+ SHIFT + L", hl.dsp.dpms({ action = "toggle" }))
-- win + o = expo

-- Window action
hl.bind(main .. " + Q", hl.dsp.window.close())
hl.bind(main .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main .. " + P", hl.dsp.window.pseudo())
hl.bind(main .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(main .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(main .. " + C", hl.dsp.window.center())

-- Window focus
hl.bind(main .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(main .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(main .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(main .. " + down", hl.dsp.focus({ direction = "down" }))

-- Window move
hl.bind(main .. " + CONTROL + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(main .. " + CONTROL + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(main .. " + CONTROL + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(main .. " + CONTROL + down", hl.dsp.window.move({ direction = "down" }))

-- Window workspace
hl.bind(main .. " + SHIFT + Next", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(main .. " + SHIFT + Prior", hl.dsp.window.move({ workspace = "-1" }))

-- Window resize
hl.bind(main .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Workspace focus
hl.bind(main .. " + Next", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(main .. " + Prior", hl.dsp.focus({ workspace = "e-1" }))

-- Captura una region
hl.bind("Print", hl.dsp.exec_cmd(screenshot))

-- Captura ventana activa con Flameshot usando --region
hl.bind("ALT + Print", function()
    local w = hl.get_active_window()

    if w == nil then
        return
    end

    -- Flameshot --region espera "WxH+X+Y"
    local region = string.format(
        "%dx%d+%d+%d",
        w.size.x, -- ancho
        w.size.y, -- alto
        w.at.x,   -- posición X
        w.at.y    -- posición Y
    )

    hl.exec_cmd(string.format("QT_ENABLE_HIGHDPI_SCALING=0 flameshot gui --region '%s'", region))
end)

-- Multimedia
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86Launch5", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86Launch6", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SOURCE@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
    { locked = true, repeating = true })

-- ########################################################################################################
-- # Windows and Workspaces                                                                               #
-- ########################################################################################################
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful
local suppressMaximizeRule = hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- blur
hl.layer_rule({
    match = { namespace = "vicinae" },
    name = "vicinae-blur",
    blur = true,
    ignore_alpha = 0,
})

-- disable animation for vicinae only
hl.layer_rule({
    match = { namespace = "vicinae" },
    name = "vicinae-no-animation",
    no_anim = true,
})

hl.window_rule({
    name = "flameshot",
    match = { class = "flameshot" },
    float = true,
    move = { 0, 0 },
    rounding = 0,
    border_size = 0,
    pin = true,
    no_anim = true,
    stay_focused = true,
    no_blur = false,
    no_shadow = true,
    fullscreen_state = "0 0",
    size = { "(monitor_w*1)", "(monitor_h)" },
})

--local function on_float_rule(class_id, w, h)
--    hl.window_rule({
--        match  = {
--            class    = class_id,
--            floating = true, -- solo matchea cuando ya es flotante
--        },
--        size   = { w, h },
--        center = true,
--    })
--end

--on_float_rule("org.gnome.Calculator", 420, 550)

hl.workspace_rule({ workspace = "1", persistent = true, default = true })
hl.workspace_rule({ workspace = "2", persistent = true })
hl.workspace_rule({ workspace = "3", persistent = true })
hl.workspace_rule({ workspace = "4", persistent = true })
