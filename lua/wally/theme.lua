local util = require("wally.util")
local colors = require("wally.colors")

local M = {}

M.setup = function(config)
    config = config or require("wally.config")

    ---@class Theme
    local theme = {}
    theme.config = config
    theme.colors = colors.setup(config)
    local c = theme.colors

    theme.base = {
        -- Syntax group {{{
        Boolean = { fg = c.yellow },
        Comment = { fg = c.comment, style = config.commentStyle }, -- any comment
        Constant = { fg = c.cyan },
        Character = { fg = c.green },
        Conditional = { fg = c.magenta },
        -- Debug = {},
        Define = { fg = c.magenta },
        -- Delimiter = {},
        Error = { fg = c.error },
        Exception = { fg = c.magenta },
        Float = { fg = c.yellow },
        Function = { fg = c.blue, style = config.functionStyle }, -- function name (also: methods for classes)
        Identifier = { fg = c.red, style = config.variableStyle }, -- (preferred) any variable name
        -- Ignore = {},
        Include = { fg = c.blue },
        Keyword = { fg = c.red, style = config.keywordStyle }, --  any other keyword
        Label = { fg = c.magenta },
        Macro = { fg = c.magenta },
        Number = { fg = c.yellow },
        Operator = { fg = c.blue5 }, -- "sizeof", "+", "*", etc.
        PreProc = { fg = c.yellow },
        PreCondit = { fg = c.yellow },
        Repeat = { fg = c.magenta },
        Statement = { fg = c.magenta },
        StorageClass = { fg = c.yellow },
        Special = { fg = c.blue1 },
        SpecialChar = { fg = c.yellow },
        Structure = { fg = c.yellow },
        String = { fg = c.green },
        SpecialComment = { fg = c.grey1 },
        -- Tag = {},
        Typedef = { fg = c.yellow },
        Type = { fg = c.blue1 }, -- (preferred) int, long, char, etc.
        Todo = { fg = c.magenta },

        Underlined = { fg = c.none, style = "underline" },
        Bold = { style = "bold" },
        Italic = { style = "italic" },
        -- }}}

        -- Hightlight Group {{{
        ColorColumn = { fg = c.none, bg = c.grey },
        Conceal = { fg = c.dark5 }, -- placeholder characters substituted for concealed text (see 'conceallevel')
        CursorColumn = { bg = c.bg_highlight }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
        CursorLine = { bg = c.bg_highlight }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
        CursorLineNr = { fg = c.blue },
        CursorIM = { style = "reverse" },
        Cursor = { style = "reverse" },
        CursorWord = { style = "underline" },
        DiffAdd = { bg = c.diff.add }, -- diff mode: Added line |diff.txt|
        DiffChange = { bg = c.diff.change }, -- diff mode: Changed line |diff.txt|
        DiffDelete = { bg = c.diff.delete }, -- diff mode: Deleted line |diff.txt|
        DiffText = { bg = c.diff.text }, -- diff mode: Changed text within a changed line |diff.txt|
        Directory = { fg = c.blue }, -- directory names (and other special names in listings)
        EndOfBuffer = { fg = c.bg },
        ErrorMsg = { fg = c.error, style = "bold" },
        Folded = { fg = c.blue, bg = c.bg_highlight }, -- line used for closed folds
        FoldColumn = { bg = c.bg, fg = c.comment }, -- 'foldcolumn'
        FloatBorder = { fg = c.border_highlight },
        iCursor = { style = "reverse" },
        IncSearch = { fg = c.grey, bg = c.yellow, style = c.none },
        lCursor = { style = "reverse" },
        LineNr = { fg = c.grey1 },
        MatchParen = { fg = c.fg_dark }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        ModeMsg = { fg = c.fg_dark, style = "bold" }, -- 'showmode' message (e.g., "-- INSERT -- ")
        MsgArea = { fg = c.fg_dark }, -- Area for messages and cmdline
        -- MsgSeparator= { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
        MoreMsg = { fg = c.blue }, -- |more-prompt|
        NonText = { fg = c.dark3 }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Normal = { fg = c.fg, bg = config.transparent and c.none or c.bg }, -- normal text
        NormalNC = { fg = c.fg, bg = config.transparent and c.none or c.bg }, -- normal text in non-current windows
        NormalSB = { fg = c.fg_sidebar, bg = c.bg_sidebar }, -- normal text in non-current windows
        NormalFloat = { fg = c.fg, bg = c.bg_float }, -- Normal text in floating windows.
        Pmenu = { bg = c.bg_popup, fg = c.fg }, -- Popup menu: normal item.
        PmenuSel = { fg = c.grey, bg = c.blue },
        PmenuSelBold = { fg = c.grey, g = c.blue },
        PmenuSbar = { fg = c.none, bg = c.grey },
        PmenuThumb = { fg = c.purple, bg = c.green },
        Question = { fg = c.yellow },
        QuickFixLine = { fg = c.magenta, style = "bold" },
        StatusLine = { fg = c.fg_sidebar, bg = c.bg_statusline }, -- status line of current window
        StatusLineNC = { fg = c.fg_gutter, bg = c.bg_statusline }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        SpellBad = { fg = c.error, sp = c.error }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        SpellCap = { fg = c.warning, sp = c.warning }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellLocal = { fg = c.info, sp = c.info }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellRare = { fg = c.hint, sp = c.hint }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
        SignColumn = { bg = config.transparent and c.none or c.bg, fg = c.fg_gutter }, -- column where |signs| are displayed
        SignColumnSB = { bg = c.bg_sidebar, fg = c.fg_gutter }, -- column where |signs| are displayed
        Substitute = { bg = c.warning, fg = c.black }, -- |:substitute| replacement text highlighting
        Search = { bg = c.bg_search, fg = c.fg }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
        SpecialKey = { fg = c.dark3 }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
        TabLine = { bg = c.bg_statusline, fg = c.fg_gutter }, -- tab pages line, not active tab page label
        TabLineFill = { bg = c.black }, -- tab pages line, where there are no labels
        TabLineSel = { fg = c.black, bg = c.blue }, -- tab pages line, active tab page label
        Title = { fg = c.blue, style = "bold" }, -- titles for output from ":set all", ":autocmd" etc.
        Terminal = { fg = c.fg, bg = c.bg },
        VertSplit = { fg = c.border }, -- the column separating vertically split windows
        vCursor = { style = "reverse" },
        Visual = { fg = c.none, bg = c.bg_visual },
        VisualNOS = { fg = c.bg, bg = c.fg },
        WarningMsg = { fg = c.warning }, -- warning messages
        Whitespace = { fg = c.grey }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
        WildMenu = { bg = c.bg_visual }, -- current match in 'wildmenu' completion
        -- }}}

        -- LSP {{{
        LspDiagnosticsError = { fg = c.error },
        LspDiagnosticsWarning = { fg = c.warning },
        LspDiagnosticsInformation = { fg = c.info },
        LspDiagnosticsHint = { fg = c.hint },

        LspDiagnosticsDefaultError = { fg = c.error },
        LspDiagnosticsDefaultWarning = { fg = c.warning },
        LspDiagnosticsDefaultInformation = { fg = c.info },
        LspDiagnosticsDefaultHint = { fg = c.hint },

        LspDiagnosticsSignError = { fg = c.error }, -- Used for "Error" signs in sign column
        LspDiagnosticsSignWarning = { fg = c.warning }, -- Used for "Warning" signs in sign column
        LspDiagnosticsSignInformation = { fg = c.info }, -- Used for "Information" signs in sign column
        LspDiagnosticsSignHint = { fg = c.hint }, -- Used for "Hint" signs in sign column

        LspDiagnosticsVirtualTextError = { fg = c.error },
        LspDiagnosticsVirtualTextWarning = { fg = c.warning },
        LspDiagnosticsVirtualTextInformation = { fg = c.info },
        LspDiagnosticsVirtualTextHint = { fg = c.hint },

        LspDiagnosticsFloatingError = { fg = c.error }, -- Used to color "Error" diagnostic messages in diagnostics float
        LspDiagnosticsFloatingWarning = { fg = c.warning }, -- Used to color "Warning" diagnostic messages in diagnostics float
        LspDiagnosticsFloatingInformation = { fg = c.info }, -- Used to color "Information" diagnostic messages in diagnostics float
        LspDiagnosticsFloatingHint = { fg = c.hint }, -- Used to color "Hint" diagnostic messages in diagnostics float

        LspDiagnosticsUnderlineError = { sp = c.error }, -- Used to underline "Error" diagnostics
        LspDiagnosticsUnderlineWarning = { sp = c.warning }, -- Used to underline "Warning" diagnostics
        LspDiagnosticsUnderlineInformation = { sp = c.info }, -- Used to underline "Information" diagnostics
        LspDiagnosticsUnderlineHint = { sp = c.hint }, -- Used to underline "Hint" diagnostics

        LspReferenceText = { bg = c.fg_gutter }, -- used for highlighting "text" references
        LspReferenceRead = { bg = c.fg_gutter }, -- used for highlighting "read" references
        LspReferenceWrite = { bg = c.fg_gutter }, -- used for highlighting "write" references

        LspSignatureActiveParameter = { fg = c.orange },
        LspCodeLens = { fg = c.comment },
        -- }}}

        -- Quickfix
        qfLineNr = { fg = c.dark5 },
        qfFileName = { fg = c.blue },

        -- HTML
        -- htmlLink = { fg = c.blue, style = "underline" },
        -- htmlH1 = { fg = c.blue, style = "bold" },
        -- htmlH2 = { fg = c.magenta, style = "bold" },
        -- htmlH3 = { fg = c.green, style = "bold" },
        -- htmlH4 = { fg = c.yellow, style = "bold" },
        -- htmlH5 = { fg = c.purple, style = "bold" },

        -- Markdown {{{
        -- mkdHeading = { fg = c.orange, style = "bold" },
        -- markdownHeadingDelimiter = { fg = c.orange, style = "bold" },

        -- markdownH1 = { fg = c.blue, style = "bold" },
        -- markdownH2 = { fg = c.magenta, style = "bold" },
        -- markdownH3 = { fg = c.green, style = "bold" },
        -- markdownH1Delimiter = { link = "markdownH1" },
        -- markdownH2Delimiter = { link = "markdownH2" },
        -- markdownH3Delimiter = { link = "markdownH3" },

        -- mkdLink = { fg = c.blue, style = "underline" },
        -- markdownLinkText = { fg = c.blue, style = "underline" },

        -- markdownCode = { fg = c.teal },
        -- markdownCodeBlock = { fg = c.teal },
        -- mkdCode = { bg = c.terminal_black, fg = c.fg },
        -- mkdCodeDelimiter = { bg = c.terminal_black, fg = c.fg },
        -- mkdCodeStart = { fg = c.teal, style = "bold" },
        -- mkdCodeEnd = { fg = c.teal, style = "bold" },
        -- }}}

        -- Lua
        -- luaTSProperty = { fg = c.red }, -- Same as `TSField`.

        -- Debug
        debugPC = { bg = c.bg_sidebar }, -- used for highlighting the current line in terminal-debug
        debugBreakpoint = { bg = util.darken(c.info, 0.1), fg = c.info }, -- used for breakpoint colors in terminal-debug

        -- Health
        healthError = { fg = c.error },
        healthSuccess = { fg = c.info },
        healthWarning = { fg = c.warning },
    }

    theme.plugins = {
        -- Treesitter {{{
        TSAnnotation = { fg = c.blue },
        TSAttribute = { fg = c.yellow },
        TSBoolean = { link = "Boolean" },
        TSCharacter = { fg = c.green },
        TSComment = { link = "Comment" }, -- For comment blocks.
        TSConditional = { fg = c.magenta },
        TSConstructor = { fg = c.blue },
        TSConstant = { fg = c.yellow },
        TSConstBuiltin = { fg = c.blue },
        TSConstMacro = { fg = c.magenta },
        TSError = { fg = c.error },
        TSException = { fg = c.red },
        TSField = { fg = c.yellow },
        TSFloat = { fg = c.yellow },
        TSFunction = { link = "Function" },
        TSFuncMacro = { link = "Function" },
        TSFuncBuiltin = { link = "Function" },
        TSInclude = { fg = c.red },
        TSKeyword = { fg = c.magenta, style = config.keywordStyle }, -- For keywords that don't fall in previous categories.
        TSKeywordFunction = { fg = c.magenta, style = config.functionStyle }, -- For keywords used to define a fuction.
        TSKeywordOperator = { fg = c.blue5, style = config.keywordStyle },
        TSKeywordReturn = { fg = c.cyan, style = config.keywordStyle },
        TSLabel = { fg = c.magenta },
        TSMethod = { fg = c.blue },
        TSNamespace = { fg = c.blue },
        TSNone = {}, -- TODO: docs
        TSNumber = { fg = c.yellow },
        TSOperator = { link = "Operator" },
        TSParameter = { fg = c.red },
        TSParameterReference = { fg = c.red },
        TSProperty = { fg = c.red },
        TSPunctBracket = {},
        TSPunctDelimiter = { fg = c.cyan },
        TSPunctSpecial = { fg = c.cyan },
        TSRepeat = { fg = c.magenta },
        TSString = { fg = c.green },
        TSStringRegex = { fg = c.red },
        TSStringEscape = { fg = c.magenta }, -- For escape characters within a string.
        TSSymbol = {}, -- For identifiers referring to symbols or atoms.
        TSType = { fg = c.blue },
        TSTypeBuiltin = { fg = c.red },
        TSVariable = { style = config.variableStyle }, -- Any variable name that does not have another highlight.
        TSVariableBuiltin = { fg = c.blue },
        TSTag = {}, -- Tags like html tag names.
        TSTagDelimiter = {}, -- Tag delimiter like `<` `>` `/`
        TSText = {}, -- For strings considered text in a markup language.
        TSTextReference = { fg = c.teal },
        TSEmphasis = { fg = c.cyan },
        TSUnderline = { fg = c.yellow },
        TSStructure = { fg = c.yellow },
        TSStrong = { fg = c.magenta },
        TSStrike = {}, -- For strikethrough text.
        TSTitle = { fg = c.yellow },
        TSLiteral = { fg = c.green },
        TSURI = { fg = c.green },

        TSNote = { fg = c.bg, bg = c.info },
        TSWarning = { fg = c.bg, bg = c.warning },
        TSDanger = { fg = c.bg, bg = c.error },
        -- }}}

        -- LspTrouble
        LspTroubleText = { fg = c.fg_dark },
        LspTroubleCount = { fg = c.magenta, bg = c.fg_gutter },
        LspTroubleNormal = { fg = c.fg_sidebar, bg = c.bg_sidebar },

        -- ALE
        ALEErrorSign = { fg = c.error },
        ALEWarningSign = { fg = c.warning },

        -- Illuminate
        illuminatedWord = { bg = c.fg_gutter },
        illuminatedCurWord = { bg = c.fg_gutter },

        -- nvim-compe
        CmpDocumentation = { link = "Pmenu" },
        CmpDocumentationBorder = { link = "Pmenu" },

        -- diff
        diffAdded = { fg = c.git.add },
        diffRemoved = { fg = c.git.delete },
        diffChanged = { fg = c.git.change },
        diffOldFile = { fg = c.yellow },
        diffNewFile = { fg = c.orange },
        diffFile = { fg = c.blue },
        diffLine = { fg = c.comment },
        diffIndexLine = { fg = c.magenta },

        -- Neogit
        NeogitBranch = { fg = c.magenta },
        NeogitRemote = { fg = c.purple },
        NeogitHunkHeader = { bg = c.bg_highlight, fg = c.fg },
        NeogitHunkHeaderHighlight = { bg = c.fg_gutter, fg = c.blue },
        NeogitDiffContextHighlight = { bg = util.darken(c.fg_gutter, 0.5), fg = c.fg_dark },
        NeogitDiffDeleteHighlight = { fg = c.git.delete, bg = c.diff.delete },
        NeogitDiffAddHighlight = { fg = c.git.add, bg = c.diff.add },

        -- GitGutter
        GitGutterAdd = { fg = c.gitSigns.add }, -- diff mode: Added line |diff.txt|
        GitGutterChange = { fg = c.gitSigns.change }, -- diff mode: Changed line |diff.txt|
        GitGutterDelete = { fg = c.gitSigns.delete }, -- diff mode: Deleted line |diff.txt|

        -- GitSigns
        GitSignsAdd = { fg = c.gitSigns.add }, -- diff mode: Added line |diff.txt|
        GitSignsChange = { fg = c.gitSigns.change }, -- diff mode: Changed line |diff.txt|
        GitSignsDelete = { fg = c.gitSigns.delete }, -- diff mode: Deleted line |diff.txt|

        -- Telescope
        TelescopeBorder = { fg = c.border_highlight },
        TelescopePromptBorder = { fg = c.blue },

        -- NvimTree
        NvimTreeNormal = { fg = c.fg_sidebar, bg = c.bg_sidebar },
        NvimTreeRootFolder = { fg = c.blue, style = "bold" },
        NvimTreeGitDirty = { fg = c.git.change },
        NvimTreeGitNew = { fg = c.git.add },
        NvimTreeGitDeleted = { fg = c.git.delete },
        NvimTreeSpecialFile = { fg = c.purple, style = "underline" },
        NvimTreeIndentMarker = { fg = c.fg_gutter },
        NvimTreeImageFile = { fg = c.fg_sidebar },
        NvimTreeSymlink = { fg = c.blue },
        NvimTreeEmptyFolderName = { fg = c.blue },
        NvimTreeOpenedFolderName = { fg = c.blue },
        NvimTreeFolderName = { fg = c.blue },
        NvimTreeFolderIcon = { fg = c.blue },

        -- Fern
        FernBranchText = { fg = c.blue },

        -- glyph palette
        GlyphPalette1 = { fg = c.red1 },
        GlyphPalette2 = { fg = c.green },
        GlyphPalette3 = { fg = c.yellow },
        GlyphPalette4 = { fg = c.blue },
        GlyphPalette6 = { fg = c.green1 },
        GlyphPalette7 = { fg = c.fg },
        GlyphPalette9 = { fg = c.red },

        -- Dashboard
        DashboardShortCut = { fg = c.cyan },
        DashboardHeader = { fg = c.blue },
        DashboardCenter = { fg = c.magenta },
        DashboardFooter = { fg = c.yellow, style = "italic" },

        -- WhichKey
        WhichKey = { fg = c.cyan },
        WhichKeyGroup = { fg = c.blue },
        WhichKeyDesc = { fg = c.magenta },
        WhichKeySeparator = { fg = c.comment },
        WhichKeyFloat = { bg = c.bg_sidebar },
        WhichKeyValue = { fg = c.dark5 },

        -- LspSaga
        DiagnosticError = { fg = c.error },
        DiagnosticWarning = { fg = c.warning },
        DiagnosticInformation = { fg = c.info },
        DiagnosticHint = { fg = c.hint },

        LspFloatWinNormal = { bg = c.bg_float },
        LspFloatWinBorder = { fg = c.border_highlight },
        LspSagaBorderTitle = { fg = c.cyan },
        LspSagaHoverBorder = { fg = c.blue },
        LspSagaRenameBorder = { fg = c.green },
        LspSagaDefPreviewBorder = { fg = c.green },
        LspSagaCodeActionBorder = { fg = c.blue },
        LspSagaFinderSelection = { fg = c.bg_visual },
        LspSagaCodeActionTitle = { fg = c.blue1 },
        LspSagaCodeActionContent = { fg = c.purple },
        LspSagaSignatureHelpBorder = { fg = c.red },

        ReferencesCount = { fg = c.purple },
        DefinitionCount = { fg = c.purple },
        DefinitionIcon = { fg = c.blue },
        ReferencesIcon = { fg = c.blue },
        TargetWord = { fg = c.cyan },

        -- BufferLine
        BufferLineIndicatorSelected = { fg = c.git.change },
        BufferLineFill = { bg = c.black },

        -- Barbar
        BufferCurrent = { bg = c.fg_gutter, fg = c.fg },
        BufferCurrentIndex = { bg = c.fg_gutter, fg = c.info },
        BufferCurrentMod = { bg = c.fg_gutter, fg = c.warning },
        BufferCurrentSign = { bg = c.fg_gutter, fg = c.info },
        BufferCurrentTarget = { bg = c.fg_gutter, fg = c.red },
        BufferVisible = { bg = c.bg_statusline, fg = c.fg },
        BufferVisibleIndex = { bg = c.bg_statusline, fg = c.info },
        BufferVisibleMod = { bg = c.bg_statusline, fg = c.warning },
        BufferVisibleSign = { bg = c.bg_statusline, fg = c.info },
        BufferVisibleTarget = { bg = c.bg_statusline, fg = c.red },
        BufferInactive = { bg = c.bg_statusline, fg = c.dark5 },
        BufferInactiveIndex = { bg = c.bg_statusline, fg = c.dark5 },
        BufferInactiveMod = { bg = c.bg_statusline, fg = util.darken(c.warning, 0.7) },
        BufferInactiveSign = { bg = c.bg_statusline, fg = c.border_highlight },
        BufferInactiveTarget = { bg = c.bg_statusline, fg = c.red },
        BufferTabpages = { bg = c.bg_statusline, fg = c.none },
        BufferTabpage = { bg = c.bg_statusline, fg = c.border_highlight },

        -- Sneak
        Sneak = { fg = c.bg_highlight, bg = c.magenta },
        SneakScope = { bg = c.bg_visual },

        -- Hop
        HopNextKey = { fg = c.magenta2, style = "bold" },
        HopNextKey1 = { fg = c.blue2, style = "bold" },
        HopNextKey2 = { fg = util.darken(c.blue2, 0.3) },
        HopUnmatched = { fg = c.dark3 },

        -- Lightspeed
        LightspeedGreyWash = { fg = c.dark3 },

        -- nvim-notify
        NotifyERROR = { fg = c.error },
        NotifyWARN = { fg = c.warning },
        NotifyINFO = { fg = c.info },
        NotifyDEBUG = { fg = c.blue7 },
        NotifyTRACE = { fg = c.fg },
        NotifyERRORTitle = { fg = c.red1 },
        NotifyWARNTitle = { fg = c.yellow },
        NotifyINFOTitle = { fg = c.hint },
        NotifyDEBUGTitle = { fg = c.blue2 },
        NotifyTRACETitle = { fg = c.fg_dark },

        -- Snap
        SnapSelect = { fg = c.blue, bg = c.bg_highlight },
        SnapMultiSelect = { fg = c.cyan, bg = c.bg_visual },
        SnapNormal = { fg = c.fg },
        SnapBorder = { link = "SnapNormal" },
        SnapPrompt = { fg = c.border_highlight, style = "bold" },
        SnapPosition = { fg = c.blue, style = "bold" },

        -- Indent Blankline
        IndentBlanklineChar = { link = "Whitespace" },
        IndentBlanklineSpaceChar = { link = "Whitespace" },
        IndentBlanklineSpaceCharBlankline = { link = "Whitespace" },
        IndentBlanklineContextChar = { link = "Label" },

        -- SnipRun
        SniprunVirtualTextOk = { bg = c.warning, fg = c.bg },
        SniprunFloatingWinOk = { fg = c.hint },
        SniprunVirtualTextErr = { bg = c.error, fg = c.bg },
        SniprunFloatingWinErr = { fg = c.error },

        -- Alpha
        AlphaHeader = { fg = c.cyan },
        AlphaFooter = { fg = c.comment, style = "italic" },
        AlphaShortcut = { fg = c.blue },
        AlphaText = { fg = c.magenta },

    }
    return theme
end

return M
