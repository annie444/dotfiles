local M = {}

---@type fun(cfg: { config: Config } | { config: Config, wezterm: Wezterm }): nil
M.apply_to_config = function(cfg)
  local config = cfg.config
  if cfg.wezterm == nil then
    cfg.wezterm = require("wezterm")
  end
  local wezterm = cfg.wezterm

  config.window_padding = {
    left = "1cell",
    right = "1cell",
    top = "1cell",
    bottom = "1cell",
  }
  config.window_frame = {
    font = wezterm.font({ family = "JetBrainsMono Nerd Font Propo", weight = "Bold" }),
    font_size = 14.0,
    active_titlebar_bg = "#282a36",
    inactive_titlebar_bg = "#504C67",
  }
  config.window_decorations = "RESIZE"
  config.use_resize_increments = true
  config.integrated_title_buttons = {}
  config.window_background_opacity = 0.9
  config.quit_when_all_windows_are_closed = true
  config.scroll_to_bottom_on_input = true
  config.scrollback_lines = 20000
  config.exit_behavior = "Close"
  config.skip_close_confirmation_for_processes_named = {
    "bash",
    "sh",
    "zsh",
    "fish",
    "tmux",
    "nu",
    "cmd.exe",
    "pwsh.exe",
    "powershell.exe",
  }
  config.detect_password_input = true
  config.enable_scroll_bar = true
  config.min_scroll_bar_height = "1cell"
end
return M
