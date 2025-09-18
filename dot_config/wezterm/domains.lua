local M = {}

---@type fun(cfg: { config: Config } | { config: Config, wezterm: Wezterm }): nil
M.apply_to_config = function(cfg)
  local config = cfg.config
  if cfg.wezterm == nil then
    cfg.wezterm = require("wezterm")
  end
  local wezterm = cfg.wezterm
  config.ssh_domains = wezterm.default_ssh_domains()
  table.insert(config.ssh_domains, {
    name = "spinoza",
    remote_address = "spinoza.ipac.caltech.edu",
    username = "annie",
    multiplexing = "WezTerm",
    ssh_option = {
      identityfile = wezterm.home_dir .. "/.ssh/ipac_ed25519",
      addkeystoagent = "yes",
      forwardagent = "yes",
      forwardx11 = "yes",
    },
  })
end
return M
