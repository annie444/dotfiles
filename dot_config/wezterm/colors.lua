local M = {}
---@type fun(cfg: { config: Config } | { config: Config, wezterm: Wezterm }): nil
M.apply_to_config = function(cfg)
  local config = cfg.config
  config.color_scheme = "Dracula (Official)"
  config.colors = {
    tab_bar = {
      inactive_tab_edge = "#282a36",
    },
  }
end
return M
