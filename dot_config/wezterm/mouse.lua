local M = {}

---@type fun(cfg: { config: Config } | { config: Config, wezterm: Wezterm }): nil
M.apply_to_config = function(cfg)
  local config = cfg.config
  config.mouse_wheel_scrolls_tabs = true
  config.hide_mouse_cursor_when_typing = true
  config.swallow_mouse_click_on_pane_focus = true
  config.swallow_mouse_click_on_window_focus = true
  config.pane_focus_follows_mouse = true
end
return M
