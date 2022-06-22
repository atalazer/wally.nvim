local util = require("wally.util")
local config = require("wally.config")
local M = {}

local path = vim.fn.expand(config.dir or "~/.cache/wal")
package.path = path.."/?.lua;" .. package.path

local colors = require("colors")
colors.bg = colors.background
colors.fg = colors.foreground
colors.grey = util.lighten(colors.black, 0.85)
colors.grey1 = util.lighten(colors.light_black, 0.85)

M.setup = function(conf)
    conf = conf or config
    local c = {}

    c = {
        bg = colors.bg,
        bg_dark = util.darken(colors.bg, 0.95),
        bg_highlight = util.darken(colors.grey, 0.960),

        fg = colors.fg,
        fg_dark = util.lighten(colors.fg, 0.95),
        fg_gutter = util.lighten(colors.fg, 0.25),

        red = colors.red,
        red1 = util.darken(colors.red, 0.90),

        green = colors.green,
        green1 = util.darken(colors.green, 0.95),
        green2 = util.darken(colors.green, 0.75),
        teal = util.darken(colors.green, 0.80),

        yellow = colors.yellow,
        orange = util.lighten(colors.yellow, 0.15),

        blue = colors.blue,
        blue0 = util.darken(colors.blue, 0.55),
        blue7 = util.darken(colors.blue, 0.45),

        cyan = colors.cyan,
        blue1 = util.darken(colors.cyan, 0.75),
        blue2 = util.darken(colors.cyan, 0.80),
        blue5 = util.darken(colors.cyan, 0.975),
        blue6 = util.lighten(colors.cyan, 0.075),

        magenta = colors.magenta,
        magenta2 = util.lighten(colors.magenta, 0.55),
        purple = util.darken(colors.magenta, 0.85),

        -- Others
        none = "NONE",
        grey = colors.grey,
        grey1 = colors.grey1,
        dark3 = util.darken(colors.fg, 0.40),
        dark5 = util.darken(colors.fg, 0.80),
        comment = util.darken(colors.fg, 0.50),
        terminal_black = util.darken(colors.black, 0.95),

        git = {
            change = util.darken(colors.blue, 0.90),
            add = util.darken(colors.green, 0.95),
            delete = util.darken(colors.red, 0.90),
            conflict = util.darken(colors.red, 0.85),
        },
        gitSigns = {
            add = util.darken(colors.green, 0.85),
            change = util.darken(colors.blue, 0.95),
            delete = util.darken(colors.red, 0.90),
        },
    }

    util.bg = c.bg

    c.diff = {
        add = util.darken(c.green2, 0.15),
        delete = util.darken(c.red1, 0.15),
        change = util.darken(c.blue7, 0.15),
        text = c.blue7,
    }

    c.git.ignore = c.dark3
    c.black = util.darken(c.bg, 0.95)
    c.border_highlight = c.blue0
    c.border = c.black

    -- Popups and statusline always get a dark background
    c.bg_popup = c.bg_dark
    c.bg_statusline = colors.grey or c.bg_dark

    -- Sidebar and Floats are configurable
    c.bg_sidebar = (conf.transparentSidebar and c.none)
        or conf.darkSidebar and c.bg_dark
        or c.bg
    c.bg_float = conf.darkFloat and c.bg_dark or c.bg

    c.bg_visual = util.darken(c.blue0, 0.15)
    c.bg_search = c.blue0
    c.fg_sidebar = c.fg_dark

    c.error = c.red1
    c.warning = c.yellow
    c.info = c.blue2
    c.hint = c.teal

    return c
end

return M
