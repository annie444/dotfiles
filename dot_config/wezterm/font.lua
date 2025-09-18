local M = {}
---@type fun(cfg: { config: Config } | { config: Config, wezterm: Wezterm }): nil
M.apply_to_config = function(cfg)
	local config = cfg.config
	if cfg.wezterm == nil then
		cfg.wezterm = require("wezterm")
	end
	local wezterm = cfg.wezterm
	config.font_size = 14.0
	config.font = wezterm.font("JetBrainsMono Nerd Font Propo")
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
	config.hyperlink_rules = wezterm.default_hyperlink_rules()
	config.warn_about_missing_glyphs = true
end

return M
