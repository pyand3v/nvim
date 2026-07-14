-- Keep startup order explicit: mappings need the leader set first, then options
-- and plugins, whose configuration may depend on both.
require("config.keymaps")
require("config.options")
require("config.lazy")
require("config.autocmds")
