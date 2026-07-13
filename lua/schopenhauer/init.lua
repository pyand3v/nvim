-- Keep startup order explicit: mappings need the leader set first, then options
-- and plugins, whose configuration may depend on both.
require("schopenhauer.remap")
require("schopenhauer.set")
require("schopenhauer.lazy")
require("schopenhauer.highlights")
