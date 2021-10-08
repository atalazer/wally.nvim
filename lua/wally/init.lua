local util = require("wally.util")
local theme = require("wally.theme")
local colors = require("wally.colors")
local config = require("wally.config")

local M = {}

function M.colorscheme()
    util.load(theme.setup())
end

M.colors = colors.setup(config)

return M
