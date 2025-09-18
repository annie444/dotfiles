local M = {}
---@type fun(cfg: { config: Config } | { config: Config, wezterm: Wezterm }): nil
M.apply_to_config = function(cfg)
  local config = cfg.config
  if cfg.wezterm == nil then
    cfg.wezterm = require("wezterm")
  end
  local wezterm = cfg.wezterm
  config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 }
  config.keys = {
    { key = "F11", mods = "",       action = wezterm.action.ToggleFullScreen },
    { key = " ",   mods = "LEADER", action = wezterm.action.SendKey({ key = " ", mods = "CTRL" }) },
    { key = "h",   mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "l",   mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
    { key = "k",   mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
    { key = "j",   mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
    { key = "H",   mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
    { key = "L",   mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
    { key = "K",   mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
    { key = "J",   mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
    {
      key = "-",
      mods = "LEADER",
      action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "\\",
      mods = "LEADER",
      action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    { key = ":",        mods = "LEADER",     action = wezterm.action.ActivateCommandPalette },
    { key = "q",        mods = "LEADER",     action = wezterm.action.CloseCurrentPane({ confirm = false }) },
    { key = "d",        mods = "LEADER",     action = wezterm.action.DetachDomain("CurrentPaneDomain") },
    { key = "v",        mods = "LEADER",     action = wezterm.action.ActivateCopyMode },
    { key = "x",        mods = "LEADER",     action = wezterm.action.ActivateCopyMode },
    { key = "f",        mods = "LEADER",     action = wezterm.action.ToggleFullScreen },
    { key = ">",        mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
    { key = "<",        mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
    { key = "L",        mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
    { key = "H",        mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
    { key = "K",        mods = "CTRL|SHIFT", action = wezterm.action.MoveTabRelative(1) },
    { key = "J",        mods = "CTRL|SHIFT", action = wezterm.action.MoveTabRelative(-1) },
    { key = "Q",        mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
    { key = "C",        mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
    { key = "V",        mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
    { key = "X",        mods = "CTRL|SHIFT", action = wezterm.action.ActivateCopyMode },
    { key = "F",        mods = "CTRL|SHIFT", action = wezterm.action.ToggleFullScreen },
    { key = "D",        mods = "CTRL|SHIFT", action = wezterm.action.ShowDebugOverlay },
    { key = "-",        mods = "CTRL",       action = wezterm.action.DecreaseFontSize },
    { key = "=",        mods = "CTRL",       action = wezterm.action.IncreaseFontSize },
    { key = "0",        mods = "CTRL",       action = wezterm.action.ResetFontSize },
    { key = "PageUp",   mods = "SHIFT",      action = wezterm.action.ScrollByPage(-1) },
    { key = "PageDown", mods = "SHIFT",      action = wezterm.action.ScrollByPage(1) },
  }
  for i = 1, 9 do
    table.insert(config.keys, {
      key = tostring(i),
      mods = "CTRL|SHIFT",
      action = wezterm.action.ActivateTab(i),
    })
  end

  for i = 1, 9 do
    table.insert(config.keys, {
      key = tostring(i),
      mods = "LEADER",
      action = wezterm.action.ActivatePaneByIndex(i),
    })
  end
end
return M

--- Commands:
-- ClearSelection
-- CloseCurrentPane
-- CloseCurrentTab
-- CompleteSelection
-- CompleteSelectionOrOpenLinkAtMouseCursor
-- Confirmation
-- Copy
-- CopyTo
-- EmitEvent
-- ExtendSelectionToMouseCursor
-- InputSelector
-- Multiple
-- Nop
-- OpenLinkAtMouseCursor
-- PaneSelect
-- Paste
-- PasteFrom
-- PastePrimarySelection
-- PopKeyTable
-- PromptInputLine
-- QuickSelect
-- QuickSelectArgs
-- QuitApplication
-- ReloadConfiguration
-- ResetFontAndWindowSize
-- ResetFontSize
-- ResetTerminal
-- RotatePanes
-- Search
-- SelectTextAtMouseCursor
-- SendKey
-- SendString
-- SetWindowLevel
-- Show
-- ShowDebugOverlay
-- ShowLauncher
-- ShowLauncherArgs
-- ShowTabNavigator
-- ToggleAlwaysOnBottom
-- ToggleAlwaysOnTop
-- TogglePaneZoomState
