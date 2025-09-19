local M = {}

---@param config Config
---@param wezterm Wezterm
local function cmd_sender_plugin(config, wezterm)
  local cmd_sender = wezterm.plugin.require("https://github.com/aureolebigben/wezterm-cmd-sender")
  cmd_sender.apply_to_config(config, {
    key = "S",
    mods = "CTRL|SHIFT",
    description = "Enter command to send to all panes of active tab",
  })
end

---@param config Config
---@param wezterm Wezterm
local function tabline_plugin(config, wezterm)
  local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
  tabline.setup({
    options = {
      icons_enabled = true,
      theme = "Dracula (Official)",
      tabs_enabled = true,
      theme_overrides = {},
      section_separators = {
        left = wezterm.nerdfonts.ple_right_half_circle_thick,
        right = wezterm.nerdfonts.ple_left_half_circle_thick,
      },
      component_separators = {
        left = "┃",
        right = "┃",
      },
      tab_separators = {
        left = wezterm.nerdfonts.ple_right_half_circle_thick,
        right = wezterm.nerdfonts.ple_left_half_circle_thick,
      },
    },
    sections = {
      tabline_a = { "mode" },
      tabline_b = { "workspace" },
      tabline_c = { " " },
      tab_active = {
        "index",
        { "parent", padding = 0 },
        "/",
        { "cwd",    padding = { left = 0, right = 1 } },
        { "zoomed", padding = 0 },
      },
      tab_inactive = {
        "index",
        { "process", padding = { left = 0, right = 1 } },
        { "output",  icon_no_output = "" },
      },
      tabline_x = { "ram", "cpu" },
      tabline_y = { "datetime", "battery" },
      tabline_z = { "domain" },
    },
    extensions = {},
  })
  tabline.apply_to_config(config)
end

---@type fun(cfg: { config: Config } | { config: Config, wezterm: Wezterm }): nil
M.apply_to_config = function(cfg)
  local config = cfg.config
  if cfg.wezterm == nil then
    cfg.wezterm = require("wezterm")
  end
  local wezterm = cfg.wezterm

  cmd_sender_plugin(config, wezterm)

  tabline_plugin(config, wezterm)
end
return M
