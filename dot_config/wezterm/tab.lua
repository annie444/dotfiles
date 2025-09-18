local M = {}
---@type fun(cfg: { config: Config } | { config: Config, wezterm: Wezterm }): nil
M.apply_to_config = function(cfg)
  local config = cfg.config
  config.enable_tab_bar = true
  config.hide_tab_bar_if_only_one_tab = false
  config.tab_max_width = 16
  config.switch_to_last_active_tab_when_closing_tab = true
  config.tab_and_split_indices_are_zero_based = false
  config.show_new_tab_button_in_tab_bar = true
  config.show_tab_index_in_tab_bar = true
  config.show_tabs_in_tab_bar = true
end
return M
