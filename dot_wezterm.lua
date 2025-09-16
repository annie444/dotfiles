local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font_size = 14.0
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_shaper = "Harfbuzz"
config.harfbuzz_features = {
	"aalt=0",
	"calt=1",
	"case=1",
	"ccmp=1",
	"cv01=0",
	"cv02=0",
	"cv03=1",
	"cv04=0",
	"cv05=0",
	"cv06=1",
	"cv07=1",
	"cv08=0",
	"cv09=0",
	"cv10=0",
	"cv11=1",
	"cv12=0",
	"cv14=1",
	"cv15=0",
	"cv16=1",
	"cv17=1",
	"cv18=0",
	"cv19=1",
	"cv20=0",
	"cv99=1",
	"frac=0",
	"ordn=0",
	"sinf=0",
	"ss01=0",
	"ss02=0",
	"ss19=0",
	"ss20=0",
	"subs=0",
	"sups=0",
	"zero=0",
	"mark=1",
	"mkmk=1",
}
config.freetype_interpreter_version = 40
config.anti_alias_custom_block_glyphs = true
config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"
config.bold_brightens_ansi_colors = "No"
config.hide_mouse_cursor_when_typing = true

config.hyperlink_rules = wezterm.default_hyperlink_rules()

config.color_scheme = "Dracula (Official)"
config.colors = {
	tab_bar = {
		inactive_tab_edge = "#282a36",
	},
}

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32

config.window_padding = {
	left = "1cell",
	right = "1cell",
	top = "1cell",
	bottom = "1cell",
}
config.window_frame = {
	font = wezterm.font({ family = "JetBrainsMono Nerd Font Mono", weight = "Bold" }),
	font_size = 14.0,
	active_titlebar_bg = "#282a36",
	inactive_titlebar_bg = "#504C67",
}
config.window_decorations = "RESIZE"
config.use_resize_increments = true
config.integrated_title_buttons = {}
config.window_background_opacity = 0.9
config.ui_key_cap_rendering = "UnixLong"

config.swallow_mouse_click_on_pane_focus = true
config.swallow_mouse_click_on_window_focus = true
config.switch_to_last_active_tab_when_closing_tab = true
config.tab_and_split_indices_are_zero_based = false

config.warn_about_missing_glyphs = true
config.notification_handling = "SuppressFromFocusedPane"
config.pane_focus_follows_mouse = true
config.quit_when_all_windows_are_closed = true
config.quote_dropped_files = "Posix"
config.scroll_to_bottom_on_input = true
config.ssh_domains = wezterm.default_ssh_domains()
config.scrollback_lines = 20000
config.show_new_tab_button_in_tab_bar = true
config.show_tab_index_in_tab_bar = true
config.show_tabs_in_tab_bar = true
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

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}

config.alternate_buffer_wheel_scroll_speed = 3
config.canonicalize_pasted_newlines = "LineFeed"

config.default_cursor_style = "SteadyBlock"
config.detect_password_input = true
config.enable_scroll_bar = true
config.min_scroll_bar_height = "1cell"
config.mouse_wheel_scrolls_tabs = true
config.exit_behavior = "Close"

local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
resurrect.apply_to_config(config)

local cmd_sender = wezterm.plugin.require("https://github.com/aureolebigben/wezterm-cmd-sender")
cmd_sender.apply_to_config(config, {
	key = "mapped:s",
	mods = "CMD|SHIFT",
	description = "Enter command to send to all panes of active tab",
})

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
	options = {
		icons_enabled = true,
		theme = "Dracula (Official)",
		tabs_enabled = true,
		theme_overrides = {},
		section_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_right_soft_divider,
		},
		tab_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
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
			{ "cwd", padding = { left = 0, right = 1 } },
			{ "zoomed", padding = 0 },
		},
		tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
		tabline_x = { "ram", "cpu" },
		tabline_y = { "datetime", "battery" },
		tabline_z = { "domain" },
	},
	extensions = {},
})
tabline.apply_to_config(config)

if wezterm.target_triple == "x86_64-unknown-linux-gnu" or wezterm.target_triple == "aarch64-unknown-linux-gnu" then
	for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
		if gpu.backend == "Gl" and gpu.device_type == "Other" then
			config.webgpu_preferred_adapter = gpu
			break
		end
	end
	config.prefer_egl = true
	config.front_end = "WebGpu"
	config.enable_wayland = false
	config.kde_window_background_blur = true
	config.webgpu_power_preference = "HighPerformance"
	resurrect.state_manager.set_encryption({
		enable = true,
		method = "gpg", -- "age" is the default encryption method, but you can also specify "rage" or "gpg"
		public_key = "0xBD0383B510975BA5",
	})
elseif wezterm.target_triple == "aarch64-apple-darwin" or wezterm.target_triple == "x86_64-apple-darwin" then
	config.front_end = "WebGpu"
	config.macos_window_background_blur = 20
	config.native_macos_fullscreen_mode = true
	resurrect.state_manager.set_encryption({
		enable = true,
		method = "/opt/homebrew/bin/gpg", -- "age" is the default encryption method, but you can also specify "rage" or "gpg"
		public_key = "0xBD0383B510975BA5",
	})
end

-- loads the state whenever I create a new workspace
wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, path, label)
	local workspace_state = resurrect.workspace_state

	workspace_state.restore_workspace(resurrect.state_manager.load_state(label, "workspace"), {
		window = window,
		relative = true,
		restore_text = true,
		on_pane_restore = resurrect.tab_state.default_on_pane_restore,
	})
end)

-- Saves the state whenever I select a workspace
wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function(window, path, label)
	local workspace_state = resurrect.workspace_state
	resurrect.state_manager.save_state(workspace_state.get_workspace_state())
end)

config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{
		key = "w",
		mods = "ALT",
		action = wezterm.action_callback(function(win, pane)
			resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
		end),
	},
	{
		key = "W",
		mods = "ALT",
		action = resurrect.window_state.save_window_action(),
	},
	{
		key = "T",
		mods = "ALT",
		action = resurrect.tab_state.save_tab_action(),
	},
	{
		key = "s",
		mods = "ALT",
		action = wezterm.action_callback(function(win, pane)
			resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
			resurrect.window_state.save_window_action()
		end),
	},
	{
		key = "r",
		mods = "ALT",
		action = wezterm.action_callback(function(win, pane)
			resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
				local type = string.match(id, "^([^/]+)") -- match before '/'
				id = string.match(id, "([^/]+)$") -- match after '/'
				id = string.match(id, "(.+)%..+$") -- remove file extention
				local opts = {
					relative = true,
					restore_text = true,
					on_pane_restore = resurrect.tab_state.default_on_pane_restore,
				}
				if type == "workspace" then
					local state = resurrect.state_manager.load_state(id, "workspace")
					resurrect.workspace_state.restore_workspace(state, opts)
				elseif type == "window" then
					local state = resurrect.state_manager.load_state(id, "window")
					resurrect.window_state.restore_window(pane:window(), state, opts)
				elseif type == "tab" then
					local state = resurrect.state_manager.load_state(id, "tab")
					resurrect.tab_state.restore_tab(pane:tab(), state, opts)
				end
			end)
		end),
	},
	{ key = "F11", mods = "", action = wezterm.action.ToggleFullScreen },
	{ key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "H", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
	{ key = "L", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
	{ key = "K", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
	{ key = "J", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
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
	{ key = ":", mods = "LEADER", action = wezterm.action.ActivateCommandPalette },
	{ key = "q", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
	{ key = "d", mods = "LEADER", action = wezterm.action.DetachDomain("CurrentPaneDomain") },
	{ key = "v", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
	{ key = "x", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
	{ key = "f", mods = "LEADER", action = wezterm.action.ToggleFullScreen },
	{ key = ">", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "<", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "L", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "H", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "K", mods = "CTRL|SHIFT", action = wezterm.action.MoveTabRelative(1) },
	{ key = "J", mods = "CTRL|SHIFT", action = wezterm.action.MoveTabRelative(-1) },
	{ key = "Q", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
	{ key = "C", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "V", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
	{ key = "X", mods = "CTRL|SHIFT", action = wezterm.action.ActivateCopyMode },
	{ key = "F", mods = "CTRL|SHIFT", action = wezterm.action.ToggleFullScreen },
	{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
	{ key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
	{ key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },
	{ key = "PageUp", mods = "SHIFT", action = wezterm.action.ScrollByPage(-1) },
	{ key = "PageDown", mods = "SHIFT", action = wezterm.action.ScrollByPage(1) },
}

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

return config
