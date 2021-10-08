local util = require("wally.util")
local config = require("wally.config")
local M = {}

local path = vim.fn.expand(config.dir or "~/.cache/wal")
package.path = path.."/?.lua;" .. package.path

local colors = require("colors")
colors.bg = colors.background
colors.fg = colors.foreground
colors.grey = "#363940"
colors.grey1 = "#363940"

M.colors = colors

M.setup = function(conf)
    conf = conf or config
    local x = colors
    local c = {}

    c = {
        bg = x.bg,
        bg_dark = util.darken(x.bg, 0.95),
        bg_highlight = util.darken(x.grey, 0.960),

        fg = x.fg,
        fg_dark = util.lighten(x.fg, 0.95),
        fg_gutter = util.lighten(x.fg, 0.25),

        red = x.red,
        red1 = util.darken(x.red, 0.90),

        green = x.green,
        green1 = util.darken(x.green, 0.95),
        green2 = util.darken(x.green, 0.75),
        teal = util.darken(x.green, 0.80),

        yellow = x.yellow,
        orange = util.lighten(x.yellow, 0.15),

        blue = x.blue,
        blue0 = util.darken(x.blue, 0.55),
        blue7 = util.darken(x.blue, 0.45),

        cyan = x.cyan,
        blue1 = util.darken(x.cyan, 0.75),
        blue2 = util.darken(x.cyan, 0.80),
        blue5 = util.darken(x.cyan, 0.975),
        blue6 = util.lighten(x.cyan, 0.075),

        magenta = x.magenta,
        magenta2 = util.lighten(x.magenta, 0.55),
        purple = util.darken(x.magenta, 0.85),

        -- Others
        none = "NONE",
        grey = x.grey,
        grey1 = x.grey1,
        dark3 = util.darken(x.fg, 0.40),
        dark5 = util.darken(x.fg, 0.80),
        comment = util.darken(x.fg, 0.50),
        terminal_black = util.darken(x.black, 0.95),

        git = {
            change = util.darken(x.blue, 0.90),
            add = util.darken(x.green, 0.95),
            delete = util.darken(x.red, 0.90),
            conflict = util.darken(x.red, 0.85),
        },
        gitSigns = {
            add = util.darken(x.green, 0.85),
            change = util.darken(x.blue, 0.95),
            delete = util.darken(x.red, 0.90),
        },
    }

    util.bg = c.bg

    c.diff = {
        add = util.darken(c.green2, 0.15),
        delete = util.darken(c.red1, 0.15),
        change = util.darken(c.blue7, 0.15),
        text = c.blue7,
    }

    -- colors.gitSigns = {
    --     add = util.lighten(colors.gitSigns.add, 0.2),
    --     change = util.lighten(colors.gitSigns.change, 0.2),
    --     delete = util.lighten(colors.gitSigns.delete, 0.2),
    -- }

    c.git.ignore = c.dark3
    c.black = util.darken(c.bg, 0.95)
    c.border_highlight = c.blue0
    c.border = c.black

    -- Popups and statusline always get a dark background
    c.bg_popup = c.bg_dark
    c.bg_statusline = x.grey or c.bg_dark

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
