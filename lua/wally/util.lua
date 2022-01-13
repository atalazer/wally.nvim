local hsluv = require("wally.hsluv")

local util = {}

util.bg = "#000000"
util.fg = "#ffffff"

local function hexToRgb(hex_str)
    local hex = "[abcdef0-9][abcdef0-9]"
    local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
    hex_str = string.lower(hex_str)

    assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

    local r, g, b = string.match(hex_str, pat)
    return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

function util.blend(fg, bg, alpha)
    bg = hexToRgb(bg)
    fg = hexToRgb(fg)

    local blendChannel = function(i)
        local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
        return math.floor(math.min(math.max(0, ret), 255) + 0.5)
    end

    return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

function util.darken(hex, amount, bg)
    return util.blend(hex, bg or util.bg, math.abs(amount))
end

function util.lighten(hex, amount, fg)
    return util.blend(hex, fg or util.fg, math.abs(amount))
end

function util.brighten(color, percentage)
    local hsl = hsluv.hex_to_hsluv(color)
    local larpSpace = 100 - hsl[3]
    if percentage < 0 then
        larpSpace = hsl[3]
    end
    hsl[3] = hsl[3] + larpSpace * percentage
    return hsluv.hsluv_to_hex(hsl)
end

function util.highlight(group, color)
    local style = color.style and "gui=" .. color.style or "gui=NONE"
    local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
    local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
    local sp = color.sp and "guisp=" .. color.sp or ""

    local hl = "highlight " .. group .. " " .. style .. " " .. fg .. " " .. bg .. " " .. sp

    if color.link then
        vim.cmd("highlight! link " .. group .. " " .. color.link)
    else
        vim.cmd(hl)
    end
end

--- Delete the autocmds when the theme changes to something else
function util.onColorScheme()
    if vim.g.colors_name ~= "wally" then
        vim.cmd([[autocmd! wally]])
        vim.cmd([[augroup! wally]])
    end
end

function util.autocmds(config)
    vim.cmd([[augroup wally]])
    vim.cmd([[  autocmd!]])
    vim.cmd([[  autocmd ColorScheme * lua require("wally.util").onColorScheme()]])
    for _, sidebar in ipairs(config.sidebars) do
        if sidebar == "terminal" then
            vim.cmd([[  autocmd TermOpen * setlocal winhighlight=Normal:NormalSB,SignColumn:SignColumnSB]])
        else
            vim.cmd(
                [[  autocmd FileType ]] .. sidebar .. [[ setlocal winhighlight=Normal:NormalSB,SignColumn:SignColumnSB]]
            )
        end
    end
    vim.cmd([[augroup end]])
end

function util.syntax(syntax)
    for group, colors in pairs(syntax) do
        util.highlight(group, colors)
    end
end

function util.terminal(colors)
    -- dark
    vim.g.terminal_color_0 = colors.black
    vim.g.terminal_color_8 = colors.terminal_black

    -- light
    vim.g.terminal_color_7 = colors.fg_dark
    vim.g.terminal_color_15 = colors.fg

    -- colors
    vim.g.terminal_color_1 = colors.red
    vim.g.terminal_color_9 = colors.red1

    vim.g.terminal_color_2 = colors.teal
    vim.g.terminal_color_10 = colors.green

    vim.g.terminal_color_3 = colors.yellow
    vim.g.terminal_color_11 = colors.orange

    vim.g.terminal_color_4 = colors.blue
    vim.g.terminal_color_12 = colors.blue5

    vim.g.terminal_color_5 = colors.magenta
    vim.g.terminal_color_13 = colors.magenta2

    vim.g.terminal_color_6 = colors.blue6
    vim.g.terminal_color_14 = colors.cyan

end

function util.load(theme)
    -- only needed to clear when not the default colorscheme
    if vim.g.colors_name then
        vim.cmd("hi clear")
    end

    -- if vim.fn.exists("syntax_on") then
    --     vim.cmd("syntax reset")
    -- end

    vim.o.termguicolors = true
    vim.g.colors_name = "wally"

    -- load base theme
    util.syntax(theme.base)
    util.syntax(theme.plugins)

    if theme.config.terminalColors then
        util.terminal(theme.colors)
    end

    util.autocmds(theme.config)

end

return util
