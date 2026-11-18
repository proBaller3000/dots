# Foundation

## Layout

~/.config/nvim2: the config root folder
- init.lua: enables vim.loader for faster startup, then requires these files
  directly, in order:
  1. pblr.utils, assigned to the global Pblr
  2. pblr.config.options, .keymaps, .autocmds, .commands, .workarounds
  3. pblr.plugins
- lua/pblr/: my config lives here
  - utils/: shared helpers
    - init.lua: returns a table of helper modules, empty for now.
      - Later steps add modules like utils/editor.lua, exposed as editor.
  - config/: plain Neovim settings, one file per name above
  - plugins/
    - init.lua: installs every plugin in one vim.pack.add call, then requires
      each group file
    - Each plugin group gets its own file next to it (e.g. ui.lua), which
      configures its plugins with require("<plugin>").setup({ ... }).
    - keymaps.lua: every keymap that uses a plugin, required last so all
      plugins are set up first. Group files hold no keymaps.
- Lua files are formatted by stylua with its defaults.

## Leader and basics

- Leader and local leader are Space.
- Clipboard is unnamedplus, so yank and paste go through the system clipboard.
- Indent is 2 spaces:
  - tabstop, shiftwidth, and softtabstop are all 2
  - expandtab and smartindent are on
- `-` counts as part of a word, so foo-bar is one word.
  - fits kebab-case names.

## Look of the buffer

- **Hybrid** line numbers: `number` + `relativenumber` **on**, so the cursor
  line shows its real number.
- No wrap, `scrolloff` **10**, `sidescrolloff` **8**.
- `signcolumn` **always on**.
  - Text doesn't jump when git or diagnostic marks appear.
- `cmdheight` **0** and one global statusline (`laststatus` **3**).
  - Maximizes vertical space.
- **Rounded** borders on every float (`winborder`).
- Popup menu: at most **10** rows, slightly see-through (`pumheight` **10**,
  `pumblend` **80**).
- Matching brackets flash briefly (`showmatch` **on**, `matchtime` **2**).
- `title` **on**, so the terminal tab shows the file name.
- Diagonal `╱` fill in empty diff areas.

## Search, files, undo

- `ignorecase` + `smartcase` **on**: case-insensitive until a capital letter is
  typed.
- `path` adds `**`, so `:find` searches subfolders.
- `:` completion:
  - `wildmode` is `longest:full,full`
  - `wildignore` skips `*/node_modules/*`, `*.o`, `*.obj`, `*.pyc`, `*.class`,
    `*.jar`
- Escape exits the search highlight.
- `swapfile` and `writebackup` **off**.
- Persistent undo (`undofile` **on**) lives in `~/.cache/nvim/undodir`.
  - Undo survives closing the file. Swap files only get in the way.
- Snappier timing: `updatetime` **300**, `timeoutlen` **500**, `ttimeoutlen`
  **0**.
  - Faster CursorHold events, and key sequences resolve without lag.

Try it:

- `/pblr` in `init.lua`, then `/Pblr`
- `:find opt<Tab>`
- Edit `init.lua`, `:wq`, reopen it, then `u`

## Splits and folds

- New splits open **below** and to the **right**.
- Folds come from **Treesitter**, with `foldlevel` **99**.
  - Everything starts unfolded, and folds can still be closed by syntax.

Try it:

- `:split`, `:vsplit`
- `:e $VIMRUNTIME/lua/vim/keymap.lua`, then `zc` / `zo` inside a function
- `zM` / `zR`

## Messages

Neovim 0.12's experimental **ui2** handles messages. It's turned on at the end
of `config/options.lua`.

- Short messages: corner popup up to **30%** of the screen tall, gone after
  **5 seconds**.
- Long output (errors, `:ls`, `:verbose`, shell commands, progress): a
  scrollable pager up to **half** the screen.
- Search count, search pattern, completion, `:` completion list, and confirm
  prompts stay in the command line.
- Output of a command I type goes to the command line too, whatever its kind.
  - It expands over the bottom of the screen until the next key.
  - `Enter` moves it into the pager.

[tiny-cmdline.nvim](https://github.com/rachartier/tiny-cmdline.nvim) shows the
`:` command line as a floating box, centered left to right, **20%** from the
top. It's set up in `plugins/ui.lua`.

- With `cmdheight` 0, the command line needs somewhere to appear, and near the
  top is where the eyes already are.
- The pager and cmdline are transparent to the terminal, but the buffer
  underneath must not show through (default `winblend` 0).

Try it:

- `:echo "hi"`
- `:lua print("hi")`
- `:foo`
- `:!ls`
- `:verbose set ts?`

## Autocmds

- Yanked text flashes briefly.
- Only the active window shows the cursorline.

## Core keymaps

- `x`: delete without yanking (normal and visual modes).
- `<leader>d` / `<leader>p`: delete, paste without touching the yank register.
  (normal and visual modes)
  - Yanked text stays safe while editing around it.
- `dw`: delete the word backwards without copying.
- `vag` / `yag`: select all / yank all.
- `<leader>-` / `<leader>|`: split; `<C-hjkl>`: move between windows.
- `<leader>o` / `<leader>O`: open a line below or above, without continuing a
  comment (`o<Esc>^Da`).
- <BS> same as : - opens command mode

## Close hidden buffers

- `<leader>bo` closes every hidden buffer, except unsaved ones.

# Look & feel

## Colortheme

- Use **noctalia** nvim template to define Colortheme
- Editor background transparent (terminal shows through).
- Popups and floats keep their palette background.
- Popup menu slightly see-through (`pumblend` **10**).

## Icons

- [mini.icons](https://github.com/nvim-mini/mini.icons), also mocking
  [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons).
  - One icon source for every plugin.

## Bufferline

[bufferline](https://github.com/akinsho/bufferline.nvim) plugin with following
configs

- Shown only when there are **2** or more tabs.
- Each tab shows the active window's file name with its icon
- Terminals show `[Terminal]` and empty buffers `[No Name]`, with no icon
- `H` goes to buffer on the left `L` to the buffer on the right

## Statusline

[lualine](https://github.com/nvim-lualine/lualine.nvim), one global bar, theme
`auto`.

- `a`: mode
- `b`: git branch
- `c`: project root name (only when it differs from cwd), filetype icon, pretty
  path
- `x`: macro recording register, diagnostics, git diff counts
- `y`: progress
- `z`: line:column

The project root is found by searching upward for `.git`,`Cargo.toml`, or
`pyproject.toml`.

- Refreshes on cursor move and macro start/stop.
  - The recording indicator replaces the hidden command line.

## Snacks

[snacks.nvim](https://github.com/folke/snacks.nvim) provides the notifier,
indent guides, statuscolumn, and word highlighting.

- **Smooth scroll** is **off**.
  - Scrolling should feel instant.

## Which key

[which-key.nvim](https://github.com/folke/which-key.nvim) shows every possible
continuation after a prefix like `<leader>`, for mappings not yet in muscle
memory.

- All available default mappings are also shown `gn` `zz` etc.
- All current and future mappings are added:
  - description comes from the keymap definition
  - the icon is set separately in the which key config, because a keymap cannot
    hold one (no single source of truth for now)
  - groups that open up further mappings set their icon and description there
    too
- fixed width: 50
- adaptive height but max 0.5
- position: bottom right
- round border

# Navigating

## Flash

[flash.nvim](https://github.com/folke/flash.nvim) with default config.

- `s`: jump to a visible match in normal, visual, and operator-pending mode.
- Labels use the `CurSearch` highlight so they stand out from the matches.

## Picker

The [snacks.nvim](https://github.com/folke/snacks.nvim) picker if not
([mini.pick](https://github.com/nvim-mini/mini.pick))

"in normal mode" means the picker opens in normal mode, not insert mode. "in
insert mode" is the opposite.

- `<leader>l`: find files, including hidden ones. (mini)
- `<leader>s`: live-grep, including hidden files. in insert mode
- `<leader>w`: live-grep word that is either current search highlight or
  visually selected, including hidden files. in normal mode
- `<leader>.`: reopen the last picker in normal mode
- `<leader>,`: list open buffers in normal mode
- `<leader>E`: list diagnostics in normal mode
- `<leader>n`: notification history in normal mode
- `<leader>gH`: list git hunks

## File explorer

[oil.nvim](https://github.com/stevearc/oil.nvim) replaces netrw and shows
hidden files.

- The directory is a buffer, so renaming, moving, and deleting files is plain
  text editing followed by `:w`.
- Show: file type icon

Keys:

- `-`: opens oil as a centered float with a live preview.
  - width:0.9 height:0.9, with rounded corners.
- `-`: goes to the parent directory.
- `q`: closes oil.

- snacks file explorer as an alternative view
  - show hidden, gitignored and build files
  - `<leader>e`: opens the snacks explorer
  - `q`: closes snacks explorer

# Syntax

## Treesitter

[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter), main
branch.

- Ensures 32 parsers:
  - bash, c, cmake, cpp, css, diff, fish, gitignore, go, html, http, json, lua,
    luadoc, luap, markdown, markdown_inline, php, printf, python, query, regex,
    rust, ron, sql, svelte, toml, typescript, vim, vimdoc, xml, yaml
- A FileType autocmd starts highlighting and Treesitter indent whenever a
  parser exists.
- `:TSUpdate` runs on the `PackChanged` event.
  - Parsers stay in sync with the plugin version.

## Small highlights

- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) highlights
  `TODO`, `FIXME`, and the like, with defaults.
- [nvim-highlight-colors](https://github.com/brenoprata10/nvim-highlight-colors)
  paints hex, rgb, hsl, ANSI, and CSS variable colors as backgrounds. Tailwind
  is off.
  - Neovim's LSP document colors are turned off, so colors aren't painted
    twice.

# Code smarts

## Language servers

[Mason](https://github.com/mason-org/mason.nvim) +
[mason-tool-installer](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim)
install on start, and never auto-update:

- Servers: lua-language-server, rust-analyzer, clangd, ruff
- Formatters: stylua, shfmt, clangd, ruff
- Python type checker: pyright, run through `uvx` (no npm needed)
- clangd provides clang-tidy diagnostics and clang-format.

[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) supplies defaults.

- Servers are turned on with `vim.lsp.enable`: lua_ls, rust_analyzer, clangd,
  ruff, pyright
- Every server gets file-rename support (`didRename` / `willRename`).

## Diagnostics look

- Underlined, not updated while typing, sorted by severity.
- Inline text: `● message`, with the source only when there are several.
- Gutter icons come from the shared icon set.

For example, typing `---@type number` above `local x = "a"` in a Lua file:

- The warning is underlined, with `● Cannot assign string to number` inline and
  an icon in the gutter.
- The line also has an "unused local" hint, but the gutter shows the warning
  icon, since they are sorted by severity.
- lua_ls reports both, so no source label is shown.

## Completion

[blink.cmp](https://github.com/saghen/blink.cmp), version `^1`, `enter` preset:
Enter accepts.

- Every language server above also gets *blink.cmp*'s completion capabilities.
- Auto-brackets after functions. Docs pop up after **200 ms**.
- Menu items are colorized by Treesitter, with kind icons from the shared icon
  set.
- Ghost text is **on**.
- In the command line, the menu opens by itself for `:` commands only, with
  nothing preselected.

## Pairs

- [mini.pairs](https://github.com/nvim-mini/mini.pairs) with defaults, in
  insert and command mode.

## Formatting

- Python is formatted on save by ruff, which also provides lint diagnostics.
- C and C++ are formatted on save by clangd's clang-format.
- pyright stays for Python type checking.

## LSP keymaps

Neovim's default `gr*` LSP mappings are removed.

| Keys | Action | Notes |
| --- | --- | --- |
| `gd` | Go to definition | Via picker, like `gD`, `gy`, `gr` |
| `gD` | Go to declaration | |
| `gy` | Go to type definition | |
| `gr` | List references | |
| `gI` | Source definition | |
| `K` | Show hover docs | |
| `gK` / `<C-k>` (insert) | Show signature help | |
| `]-d` | Next diagnostic | |
| `[-d` | Prev diagnostic | |
| `<C-S-j>` | Next diagnostic with float | |
| `<leader>ca` | Show code actions | |
| `<leader>cr` | Rename symbol | |
| `<leader>cR` | Rename file, update imports | |
| `<leader>f` | Format now | |
| `<leader>cl` | Show LSP info | |

# Git

## Signs and blame

Changes are shown as colored line numbers by
[mini.diff](https://github.com/nvim-mini/mini.diff) using the `number` style.
Its colors use the theme's green (`DiagnosticOk`), orange (`DiagnosticInfo`),
and red (`DiagnosticError`) groups. Blame and staging come from
[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) with its signs
disabled.

| Keys | Action | Notes |
| --- | --- | --- |
| `<leader>gb` | Blame the line | |
| `<leader>gB` | Blame the buffer | |
| `<leader>gO` | Open the file at the last commit, in a new buffer | |
| `<leader>gs` | Stage the buffer | |
| `<leader>gh` | Stage or unstage the hunk | |
| `<leader>gr` | Reset the hunk | |
| `]h` | next hunk | |
| `[h` | prev hunk | |

- `<leader>gO` shows the context of an old change without leaving the editor.

## Diff overlay

[mini.diff](https://github.com/nvim-mini/mini.diff) overlay.

| Keys | Action | Notes |
| --- | --- | --- |
| `<leader>go` | Toggle the overlay | |

# Copy helpers

| Keys | Action | Notes |
| --- | --- | --- |
| `<leader>yf` | Copy path relative to cwd, with `#L<line>` | |
| `<leader>yp` | Copy the absolute path the same way | |
| `<leader>yc` (visual) | Copy selection as a Markdown code block | |

- Both path copies show the copied text in a notification. Pasting the path
  into an agent's prompt points it at the exact line.
  - Example: `lua/craftzdog/config/options.lua#L12`
- `<leader>yc` uses `filename="…"` and `line=…` attributes
  language names (`bash`, `python`, `docker`).

