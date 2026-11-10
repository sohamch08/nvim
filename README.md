# My Neovim Config

Personal Neovim configuration with Lazy, language servers, completion, formatting, file explorers, and a customized UI.

## Configuration layout

- `init.lua`: bootstraps Lazy, loads plugin groups, and selects Catppuccin.
- `lua/core/options.lua`: editor options, persistent undo, indentation, clipboard, and filetype-specific spell-checking.
- `lua/core/keymaps.lua`: general editing and navigation mappings.
- `lua/core/filetypes.lua`: filetype rules for Git aliases, msmtp, Notmuch, and Mutt configuration files.
- `lua/plugins/ide/`: Tree-sitter, LSP, completion, formatting, and LSP memory management.
- `lua/plugins/ui/`: themes, statusline, notifications, command UI, and cursor effects.
- `lua/plugins/`: remaining editing, search, Git, and file-management plugins.
- `lazy-lock.json`: exact plugin revisions; keep this in Git for reproducible installs.

The `ide` and `ui` folders each have an `init.lua` that returns their plugin specifications. The main configuration loads these with `require("plugins.ide")` and `require("plugins.ui")`.

### Markdown and LaTeX spell-checking

Spell-checking is configured entirely in `lua/core/options.lua`; no separate `ftplugin/` folder is needed. The `WritingSpellcheck` autocommand runs on `FileType` for `markdown` and `tex`, enabling `spell` and setting `spelllang` to `en_us` locally.

Use `]s` / `[s` to navigate spelling errors, `z=` for suggestions, and `zg` to add a word to your dictionary. To disable spell-checking in the current window temporarily, run `:setlocal nospell`; enable it again with `:setlocal spell`.

## Plugins

This inventory includes configured plugins and their dependencies. Installed does not necessarily mean loaded at startup: some wait for an event or keypress. Language servers, formatters, and Tree-sitter parsers are separate tools, not additional Neovim plugins.

### Plugin management and dependencies

| Plugin | Purpose in this configuration |
| --- | --- |
| `lazy.nvim` | Installs, updates, locks, and lazy-loads plugins. |
| `plenary.nvim` | Shared Lua utilities used by Telescope and other plugins. |
| `nui.nvim` | UI components used by Noice. |
| `nvim-web-devicons` | File and filetype icons for supported UI plugins. |

### IDE features

| Plugin | Purpose in this configuration |
| --- | --- |
| `nvim-treesitter` | Parser-based syntax highlighting and indentation. Includes Lua, Python, JavaScript, TypeScript/TSX, C, Markdown, LaTeX, BibTeX, Rasi, Typst, and other configured parsers. Files without highlight queries keep their normal syntax highlighting. |
| `nvim-lspconfig` | Language-server configurations for diagnostics, navigation, renaming, and code actions. |
| `mason.nvim` | Installs external language servers, formatters, and related tools. |
| `mason-lspconfig.nvim` | Bridges LSP configuration names and Mason package names. |
| `mason-tool-installer.nvim` | Ensures the configured external tools are installed. |
| `lazydev.nvim` | Lua development support for Neovim APIs and plugin type definitions; loads libraries as needed. |
| `fidget.nvim` | Displays language-server progress and status notifications. |
| `garbage-day.nvim` | Stops eligible LSP clients after Neovim loses focus for 15 minutes and restores them on return. Aggressive mode is disabled. |
| `nvim-cmp` | Completion menu combining language servers, snippets, buffer words, and paths. |
| `cmp-nvim-lsp` | LSP completion source and completion capability integration. |
| `cmp-buffer` | Suggests words from the buffer. |
| `cmp-path` | Filesystem path completion. |
| `LuaSnip` | Expands snippets and navigates their placeholders. |
| `cmp_luasnip` | Exposes LuaSnip snippets in the completion menu. |
| `friendly-snippets` | Collection of premade snippets loaded into LuaSnip. |
| `conform.nvim` | Formats on save and on demand, with LSP formatting as a fallback. |

Conform uses Stylua for Lua; isort then Black for Python; prettierd or Prettier for JavaScript; Prettier for JSX, TypeScript/TSX, HTML, CSS, JSON/JSONC, YAML, and Markdown; and shfmt for shell files, including Zsh. Format-on-save has a 2-second timeout. Shell formatting requests two-space indentation; Zsh uses shfmt's Zsh dialect.

Python uses Pyright for completion and type diagnostics, with Ruff for linting. Mason installs both. Diagnostics appear at the right end of the line, with underlines and gutter signs. Taplo also supports standalone TOML files outside a project. Unmodified buffers reload when Neovim detects external file changes.

Standalone Python files use their containing directory as the workspace. Taplo uses its own TOML schema catalog because Taplo 0.10 cannot read SchemaStore's current catalog; custom schema directives still work. Taplo may still log its initial default-catalog warning before applying these settings.

### Editing

| Plugin | Purpose in this configuration |
| --- | --- |
| `nvim-autopairs` | Automatically closes brackets and quotes, integrates with completion, and pairs `$` in TeX/plain TeX. |
| `flash.nvim` | Labeled jumps, Tree-sitter selections, enhanced character motions, and search navigation. Character-motion jump labels are disabled. |
| `treesj` | Uses Tree-sitter to split or join supported code structures. Requires a parser and a supported language. |
| `mini.nvim` | Full Mini plugin collection is installed; the individual modules below are configured separately. |
| `mini.comment` | Toggles comments, using context-aware comment strings. |
| `mini.files` | Column-based file explorer and filesystem editing. |
| `mini.surround` | Adds, removes, replaces, finds, and highlights surrounding delimiters. |
| `mini.splitjoin` | Splits and joins argument lists with `sk` and `sj`. |
| `mini.trailspace` | Detects and trims trailing whitespace. |
| `nvim-ts-context-commentstring` | Chooses comment syntax for the current Tree-sitter context, including mixed-language files. |
| `Comment.nvim` | Another commenting plugin is installed, but its spec currently has no setup call; the configured commenting module is `mini.comment`. |
| `vim-sleuth` | Detects indentation settings from files. |
| `todo-comments.nvim` | Highlights and searches configured TODO-style annotations. |
| `colorizer` (`catgoose/nvim-colorizer.lua`) | Previews color values directly in buffers. |

### Navigation and Git

| Plugin | Purpose in this configuration |
| --- | --- |
| `telescope.nvim` | Fuzzy pickers for files, text, help, diagnostics, symbols, and buffers. |
| `telescope-fzf-native.nvim` | Native fuzzy matching for Telescope; installation is conditional on `make` being available. |
| `oil.nvim` | Edits directory contents like a text buffer; configured as the default file explorer, with hidden files shown. |
| `snacks.nvim` | Explorer, pickers, indentation guides, smooth scrolling, input UI, quick file loading, Git helpers, and configured image support. Image display depends on the terminal and external tools. |
| `gitsigns.nvim` | Displays Git changes beside lines, with customized symbols and colors. No custom hunk keybindings are configured. |
| `vim-fugitive` | Git commands inside Neovim, such as `:Git`. No custom global shortcuts are configured. |
| `which-key.nvim` | Displays available keybinding continuations; uses its automatic default setup, with no custom shortcut configured. |

### UI and themes

| Plugin | Purpose in this configuration |
| --- | --- |
| `noice.nvim` | Command-line and message UI; normal messages use the mini view and warnings/errors use Notify. Noice LSP hover and signature UI are disabled. |
| `nvim-notify` | Compact notification popups with slide animation. |
| `lualine.nvim` | Statusline showing mode, branch, filename, diagnostics, diffs, file information, location, progress, pending command keys, and a `REC @register` macro-recording indicator; configured with the Nord statusline theme. |
| `modicator.nvim` | Changes cursor-line number colors according to editor mode. |
| `smear-cursor.nvim` | Animated cursor trails, including Insert mode and window/buffer movement. |
| `catppuccin` | Current editor colorscheme. |
| `rose-pine` | Alternative colorscheme. |
| `gruvbox.nvim` | Alternative colorscheme. |
| `kanagawa.nvim` | Alternative colorscheme. |
| `solarized-osaka.nvim` | Alternative colorscheme. |
| `folkeTokyonight` (`folke/tokyonight.nvim`) | Alternative colorscheme, registered under a custom Lazy name. |
| `onedark.nvim` (`mawkler/onedark.nvim`) | Additional theme installed as a dependency of Modicator. |

## Keybindings

Both `<leader>` and `<localleader>` are **Space**. Keys are case-sensitive. `C` means Ctrl, `A`/`M` means Alt, and `S` means Shift. Modes: **N** = Normal, **V** = Visual, **S** = Select, **I** = Insert, **O** = operator-pending (after an operator such as `d`), **C** = command-line.

The tables cover mappings explicitly configured here, plus the main defaults enabled by configured editing modules. Plugin-internal default keymaps are available in each plugin's help or picker help.

### General editing — `lua/core/keymaps.lua`

| Keys | Mode | Action |
| --- | --- | --- |
| `<Space>` | N, V, S | No standalone action; used as the leader prefix. |
| `<A-j>` / `<A-k>` | N, V, S | Move the current line or selection down/up and reindent. The Normal mappings also execute `gv=gv`, which reselects the previous Visual region. |
| `J` | N | Join the next line while restoring the cursor position. |
| `<C-d>` / `<C-u>` | N | Scroll half a page down/up and center the cursor. |
| `n` / `N` | N | Next/previous search match, centered and with folds opened. |
| `j` / `k` | N, V, S | Move by displayed lines, including wrapped lines. |
| `<` / `>` | V, S | Indent left/right and keep the selection. |
| `x` | N | Delete a character without overwriting registers. |
| `p` | V, S | Replace the selection without saving deleted text to the unnamed register. |
| `<leader>p` | V | Same register-preserving paste. |
| `<Esc>` | N | Clear search highlighting. |
| `Q` | N | Disabled. |
| `<leader>fp` | N | Copy the current file path to the system clipboard, with the home directory abbreviated as `~`. |
| `<leader>ss` | N | Defined here to prepare whole-file substitution of the current word, but overridden by Telescope; see conflicts below. |

### Tabs and splits — `lua/core/keymaps.lua`

| Keys | Mode | Action |
| --- | --- | --- |
| `<leader>to` | N | Open a new tab. |
| `<leader>tx` | N | Close the current tab. |
| `<leader>tn` / `<leader>tp` | N | Next/previous tab. |
| `<leader>tf` | N | Open the current file in a new tab. |
| `<leader>sv` | N | Create a vertical split. |
| `<leader>sh` | N | Defined here for a horizontal split, but overridden by Telescope. |
| `<leader>se` | N | Equalize split sizes. |
| `<leader>sx` | N | Close the current split. |

The top tab bar is hidden (`showtabline = 0`); tabs still exist and these mappings still work.

### Telescope — `lua/plugins/telescope.lua`

All global mappings in this table use Normal mode.

| Keys | Action |
| --- | --- |
| `<leader>sh` | Search help tags. |
| `<leader>sk` | Search keybindings. |
| `<leader>sf` | Find files, including hidden files, with configured exclusions. |
| `<leader>ss` | List Telescope pickers. |
| `<leader>sw` | Search for the word under the cursor. |
| `<leader>sg` | Live grep across project files. |
| `<leader>sd` | Search diagnostics. |
| `<leader>sr` | Resume the previous picker. |
| `<leader>s.` | Find recently opened files. |
| `<leader><leader>` | Find open buffers. |
| `<leader>/` | Fuzzy search lines in the current buffer. |
| `<leader>s/` | Live grep only in open files. |

Inside a Telescope prompt in Insert mode: `<C-k>` selects the previous result, `<C-j>` the next, and `<C-l>` opens the selection. Picker help is available with `<C-/>` in Insert mode or `?` in Normal mode.

### Snacks — `lua/plugins/snacks.lua`

| Keys | Mode | Action |
| --- | --- | --- |
| `<leader>lg` | N | Open Lazygit; requires the external `lazygit` executable. |
| `<leader>gl` | N | Open Lazygit log view. |
| `<leader>e` | N | Open the Snacks explorer. |
| `<leader>rN` | N | Rename the current file. |
| `<leader>dB` | N | Delete/close the current buffer, prompting as needed. |
| `<leader>pf` | N | Find files. |
| `<leader>pc` | N | Find Lua files under the active Neovim configuration directory. |
| `<leader>ps` | N | Live grep. |
| `<leader>pws` | N, V | Search the current word or selected text. |
| `<leader>pk` | N | Search keybindings in an Ivy layout. |
| `<leader>gbr` | N | Pick and switch Git branches. |
| `<leader>th` | N | Pick a colorscheme; LSP inlay-hint mapping can override this locally. |
| `<leader>vh` | N | Search help pages. |
| `<leader>pt` | N | Search all configured TODO-style comments. |
| `<leader>pT` | N | Search TODO, FORGETNOT, and FIXME comments. |
| `<C-c>` | N, inside Snacks input | Close completion/cancel the input. |
| `<C-c>` | I, inside Snacks input | Close completion/leave Insert mode. |

### Files — `lua/plugins/oil.lua` and `lua/plugins/mini.lua`

| Keys | Context | Action |
| --- | --- | --- |
| `-` | N | Open the parent directory in Oil. |
| `<leader>-` | N | Toggle the floating Oil explorer. |
| `<M-h>` | Oil | Open the selected entry in a horizontal split. |
| `q` | Oil | Close the explorer. |
| `<C-h>`, `<C-c>` | Oil | Oil's default actions for these keys are disabled. |
| `<leader>ee` | N | Open Mini Files. |
| `<leader>ef` | N | Open Mini Files at the current file and reveal the working directory. |
| `<CR>` | Mini Files | Enter the directory or open the file. |
| `L` | Mini Files | Enter a directory, or open a file and close the explorer. |
| `-` | Mini Files | Go to the parent directory. |
| `H` | Mini Files | Go to the parent directory and trim the branch to the right. |

### LSP — `lua/plugins/ide/lsp.lua`

These mappings are buffer-local and become available when a language server attaches. Actions depend on server support.

| Keys | Mode | Action |
| --- | --- | --- |
| `gd` | N | Find definitions through Telescope. |
| `gr` | N | Find references through Telescope. |
| `gI` | N | Find implementations through Telescope. |
| `gD` | N | Go to the declaration. |
| `<leader>D` | N | Find type definitions. |
| `<leader>ds` | N | Search symbols in the current document. |
| `<leader>ws` | N | Search symbols across the workspace. |
| `<leader>rn` | N | Rename the symbol under the cursor. |
| `<leader>ca` | N, V | Request code actions for the cursor or selection. |
| `<leader>th` | N | Toggle inlay hints, when the attached server supports them. |

### Completion and snippets — `lua/plugins/ide/autocompletion.lua`

| Keys | Mode | Action |
| --- | --- | --- |
| `<C-n>` / `<C-p>` | I | Select next/previous completion. |
| `<C-b>` / `<C-f>` | I | Scroll completion documentation up/down four lines. |
| `<C-y>` | I | Accept the selected completion, or the first item if none is selected. |
| `<C-Space>` | I | Request completion manually. |
| `<C-l>` | I, S | Expand a snippet or jump to its next placeholder. |
| `<C-h>` | I, S | Jump to the previous snippet placeholder. |
| `<Tab>` | I, S | Select the next completion; otherwise expand/jump through a snippet; otherwise use the normal Tab action. |
| `<S-Tab>` | I, S | Select the previous completion; otherwise jump backward in a snippet; otherwise use the normal Shift-Tab action. |

Enter is not explicitly configured to accept completion. The configuration also inherits `nvim-cmp`'s Insert-mode preset mappings.

### Formatting and structured editing

| Keys | Mode | Action |
| --- | --- | --- |
| `<leader>f` | N, V, S, O | Run Conform asynchronously; Visual mode formats the selected range. Also formats automatically before saving. |
| `<leader>cw` | N | Trim trailing whitespace with Mini Trailspace. |
| `sj` / `sk` | N, V | Join/split arguments with Mini Splitjoin. |
| `<Space>m` | N | Toggle split/join with TreeSJ. |
| `<Space>j` | N | Join a structure with TreeSJ. |
| `<Space>s` | N | Split a structure with TreeSJ. |
| `sa` + motion + delimiter | N | Add a surrounding delimiter with Mini Surround. |
| `sa` + delimiter | V | Surround the selection. |
| `ds` + delimiter | N | Delete a surrounding delimiter. |
| `sr` + old + new delimiter | N | Replace a surrounding delimiter. |
| `sf` / `sF` + delimiter | N | Find a surrounding delimiter to the right/left. |
| `sh` + delimiter | N | Highlight a surrounding delimiter. |
| `sn` | N | Change how many lines Mini Surround searches. |
| `l` / `n` suffix | Mini Surround operations | Restrict the search to the previous/next surrounding; for example, `dsl)` deletes the previous matching parentheses. |
| `gcc` | N | Toggle comment on the current line (Mini Comment default). |
| `gc` + motion | N | Toggle comments over a motion (Mini Comment default). |
| `gc` | V | Toggle comments on the selection (Mini Comment default). |
| `gc` | O | Comment text object (Mini Comment default). |
| `]t` / `[t` | N | Jump to the next/previous TODO-style comment. |

TreeSJ needs both an installed parser and language support. Its mappings are not useful in plugin-manager windows or plain text. Mini Splitjoin's default toggle mapping is disabled in favor of `sj` and `sk`.

### Flash — `lua/plugins/flash.lua`

| Keys | Mode | Action |
| --- | --- | --- |
| `zf` | N, V, O | Start a labeled Flash jump. Overrides the usual `zf` fold operator. |
| `Zf` | N, V, O | Select a Tree-sitter node with Flash. |
| `r` | O | Start a remote Flash operation. |
| `R` | O, V | Search and select a Tree-sitter range. |
| `<C-s>` | C | Toggle Flash during command-line search. |

Flash also enhances `/`, `?`, and character motions `f`, `F`, `t`, `T`, `;`, and `,`. Character jump labels are disabled, so operations such as `dts` do not need a target-label confirmation.

### Existing overlaps and context differences

These are documented as currently configured; no mappings were changed for this README.

- **`<leader>sh`**: core configuration defines horizontal split, then Telescope replaces it with help search at `VimEnter`.
- **`<leader>ss`**: core configuration defines current-word substitution, then Telescope replaces it with the picker list.
- **`<leader>th`**: globally opens the theme picker; in LSP buffers that support inlay hints, the buffer-local hint toggle takes priority.
- **`<leader>f` / `<leader>fp`**: formatting is also a prefix of copy-path, so Neovim may wait for another key before formatting.
- **`<leader>s` / `<leader>s…`**: TreeSJ split shares a prefix with search and split-window mappings.
- **`<leader>e` / `<leader>ee` / `<leader>ef`**: Snacks explorer shares a prefix with Mini Files shortcuts.
- **`<leader>p` / `<leader>pws` in Visual mode**: register-preserving paste shares a prefix with Snacks search.
- **`gr`**: the custom LSP references mapping can delay longer built-in `gr…` mappings.

To see which mapping wins, use `:verbose nmap <leader>sh` (replace the key as needed). For buffer-local LSP mappings, run this from an attached code buffer.

### Pending commands and macro recording

Incomplete Normal-mode commands appear in the statusline (`showcmd` with `showcmdloc = "statusline"`). For example, `23` appears while typing `23G` and clears when `G` executes. Start recording with `qa` (register `a`, or choose another register); `REC @a` remains visible until you press `q` to stop. Use `@a` to replay it and `@@` to repeat the last replayed macro. These are built-in keys, not custom mappings.

## Useful built-in commands

These are Neovim commands and defaults, not extra custom keybindings.

- `u` / `<C-r>`: undo/redo; persistent undo is enabled.
- `:earlier 5m` / `:later 5m`: move backward/forward through edit history.
- `:undolist`: inspect undo branches.
- `]s` / `[s`: next/previous spelling error in Markdown or TeX.
- `z=`: spelling suggestions; `zg`: add a word to the dictionary.
- `:Lazy`: plugin manager; `:Mason`: external-tool manager.
- `:ConformInfo`: inspect formatter availability and logs.
- `:checkhealth`: diagnose configuration and dependencies.
- `:messages`: message history, routed through Noice.
