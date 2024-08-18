-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- Set color scheme.
config.color_scheme = 'nord'

config.window_close_confirmation = 'NeverPrompt'

--- Font settings. {{
config.font = wezterm.font({ family = 'Menlo', weight = 'Regular' })
config.font_size = 12
--- }}

--- Window settings. {{
config.window_background_opacity = 0.98
config.initial_cols = 80
config.initial_rows = 60

-- enable scroll bar.
-- config.enable_scroll_bar = true
--- }}

--- Tab settings. {{
config.use_fancy_tab_bar = true
--config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE|MACOS_FORCE_ENABLE_SHADOW'
config.window_decorations = 'TITLE|RESIZE|MACOS_FORCE_ENABLE_SHADOW'
config.window_frame = {
    font = wezterm.font({ family = 'Menlo', weight = 'Bold'}),
    font_size = 12,

    -- Background color of tab bar.
    active_titlebar_bg = '#20232e',
    inactive_titlebar_bg = '#20232e',
}
--- }}

--- Color settings. {{
config.colors = {
    tab_bar = {
        inactive_tab_edge = '#2f333e',
        active_tab = {
            bg_color = '#2f333e',
            fg_color = '#d9dde7',
        },
        inactive_tab = {
            bg_color = '#20232e',
            fg_color = '#808080',
        },
        inactive_tab_hover = {
            bg_color = '#3a3e4a',
            fg_color = '#808080',
        },
        new_tab = {
            bg_color = '#20232e',
            fg_color = '#808080',
        },
        new_tab_hover = {
            bg_color = '#2f333e',
            fg_color = '#d9dde7',
        },
    },
}
--- }}

return config
