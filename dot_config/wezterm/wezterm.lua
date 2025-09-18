local wezterm = require("wezterm")
local config = wezterm.config_builder()

local font = require("font")
font.apply_to_config({ config = config, wezterm = wezterm })

local colors = require("colors")
colors.apply_to_config({ config = config, wezterm = wezterm })

local window = require("window")
window.apply_to_config({ config = config, wezterm = wezterm })

local tab = require("tab")
tab.apply_to_config({ config = config, wezterm = wezterm })

local mouse = require("mouse")
mouse.apply_to_config({ config = config, wezterm = wezterm })

local other = require("other")
other.apply_to_config({ config = config, wezterm = wezterm })

local gui = require("gui")
gui.apply_to_config({ config = config, wezterm = wezterm })

local domains = require("domains")
domains.apply_to_config({ config = config, wezterm = wezterm })

local plugins = require("plugins")
plugins.apply_to_config({ config = config, wezterm = wezterm })

local keys = require("keys")
keys.apply_to_config({ config = config, wezterm = wezterm })

return config
