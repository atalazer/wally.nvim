---@class Config
local config

local function opt(key, default)
    key = "wally_" .. key
    if vim.g[key] == nil then return default end
    if vim.g[key] == 0 then return false end

    return vim.g[key]
end

config = {
    dir = opt("wal_dir", "~/.cache/wal"),
    transparent = opt("transparent", false),
    commentStyle = opt("italic_comments", false) and "italic" or "NONE",
    keywordStyle = opt("italic_keywords", true) and "italic" or "NONE",
    functionStyle = opt("italic_functions", true) and "italic" or "NONE",
    variableStyle = opt("italic_variables", false) and "italic" or "NONE",
    darkFloat = opt("dark_float", true),
    darkSidebar = opt("dark_sidebar", true),
    transparentSidebar = opt("transparent_sidebar", false),
    terminalColors = opt("terminal_colors", false),
    sidebars = opt("sidebars", {}),
}

return config
