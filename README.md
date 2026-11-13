<div align="center">

# ⚡️ dotfiles / mac-setup

![macOS](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=apple&logoColor=white)
![Zsh](https://img.shields.io/badge/zsh-%23991199.svg?style=for-the-badge&logo=zsh&logoColor=white)
![Go](https://img.shields.io/badge/go-00ADD8?style=for-the-badge&logo=go&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![VSCode](https://img.shields.io/badge/VS%20Code-007ACC?style=for-the-badge&logo=visualstudiocode&logoColor=white)
![Raycast](https://img.shields.io/badge/Raycast-FF6363?style=for-the-badge&logo=raycast&logoColor=white)
![CI](https://img.shields.io/github/actions/workflow/status/cunhanina/my-mac-setup/lint.yml?style=for-the-badge&label=CI)

**The ultimate minimalist development environment.** Automated. Fast. Purple.

[The Stack](#-the-stack) • [Features](#-features) • [Shell Config](#-shell-config-zdotdir) • [VS Code](#-vs-code-config) • [Installation](#-installation)

</div>

---

## 🖼️ The Look
<div align="center">
<img width="600" height="500" alt="image" src="https://github.com/user-attachments/assets/a0f44fbb-7d62-4311-9eb1-037c40c64c1d" />
</div>

---

## 💻 The Stack

| Component | Choice | Why? |
| :--- | :--- | :--- |
| **Shell** | `Oh My Zsh` + `Starship` | Fast prompt with git status and icons. |
| **Launcher** | `Raycast` | Replaces Spotlight. Runs script commands, manages windows, clipboard history. |
| **Editor** | `VS Code` | Optimized with custom `settings.json`. |
| **Font** | `JetBrains Mono` | Best ligature support for coding. |
| **Colors** | `Dracula Purple` | High-contrast purple palette. |
| **Python** | `uv` | Replaces pip/poetry. 10x–100x faster. |
| **Go** | stdlib toolchain | `cmd/` + `internal/` layout, module-based. |

---

## ✨ Features

### 🛠 Workflow Automation (Terminal)
| Command | Function |
|:---|:---|
| `new <lang> <name> [--local\|--public]` | **Project Generator.** `py`, `cpp`, or `go`. Scaffolds, git-inits, pushes a GitHub repo (private by default, `--public`, or `--local` to skip remote). |
| `save ["msg"]` | **Smart Git Sync.** Guards against `.env`/large files, prints status summary, commits, and rebase-syncs if remote is ahead. |
| `note [done\|sub\|rm\|edit]` | **Context-Aware Tasks.** Detects git root (`todo.md`) vs global (`~/Desktop/notes.md`). Run `note done` for an interactive `fzf` multi-select picker. |
| `journal [text\|search\|edit]` | **Daily Dev Journal.** Logs timestamped thoughts under `## YYYY-MM-DD` in `~/Desktop/journal.md` and fuzzy-searches past entries via `fzf`. |
| `pj [-t\|-c] [query]` | **Project Jumper.** `fzf`-searches git projects under `~/Desktop/coding` with live status/commit/task preview. Jumps in-place (`pj`), opens a new iTerm tab (`pj -t`), or opens VS Code (`pj -c`). |
| `use [name\|off]` | **venv Activator.** Activates `.venv` in current repo or by project name. Sourced via alias — see note below. |
| `week [last]` | **Weekly Review.** Aggregates git commits, tasks completed during the week, journal days, and calendar events across all projects. |
| `morning [--quick]` | **Daily Dashboard.** Parallel-fetched weather & quote, uncommitted + unpushed git work across repos, today's/upcoming calendar, and pending tasks. |

> **`use` must stay an alias, not a binary.** It calls `source .venv/bin/activate`
> inside your *current* shell — running it as a subprocess would activate the
> venv in a child process and do nothing to your terminal. `install.sh` links
> it to `~/bin/_use.sh` and `config/aliases.zsh` defines
> `alias use='source "$HOME/bin/_use.sh"'`. If run directly as a subprocess,
> `use` detects it and prints a helpful reminder.

### ⚙️ System & Maintenance (Terminal)
| Command | Function |
|:---|:---|
| `health` | **Status Dashboard.** CPU, RAM pressure, disk, battery cycles/temp, network, dev toolchain, CLI stack check, and symlink health. |
| `update` | **System Updater.** Homebrew + `uv` + Oh My Zsh + standalone Zsh plugins in one command. |
| `clean [AppName]` | **System & App Janitor.** Flushes DNS, purges inactive RAM, cleans Homebrew/`uv` caches, or hunts down leftover `~/Library` files for `<AppName>`. |
| `pyclean [-n] [dir]` | **Python Janitor.** Recursively nukes `__pycache__`, `.ruff_cache`, `.mypy_cache`, `.pytest_cache`, `build`, `dist` (`-n` for dry-run). |

### 🔌 Raycast Extensions (install from Store)
Project search, port inspection, duplicate-file finding, and file
organization are handled by Raycast extensions — there is no terminal
fallback for these in this repo. (`pj` in `scripts/` covers project
navigation from the terminal separately.)

| Extension | Use case |
|:---|:---|
| Project Manager | Jump to a project under `~/Desktop/coding` |
| Port Manager | Inspect/kill listening ports |
| Duplicate File Finder | Find duplicate files by content |
| File Organizer | Auto-sort Downloads/Desktop |
| Clipboard History | Built-in |
| Window Management | Built-in |
| Snippets | Built-in |

---

## 🐚 Shell Config (`$ZDOTDIR`)

This repo uses the XDG `ZDOTDIR` pattern instead of dotfiles living directly
in `$HOME`:

```
~/.zshenv                    →  only sets ZDOTDIR (always read first by zsh,
                                 before ZDOTDIR itself is known — this file
                                 CANNOT move into ZDOTDIR)
~/.config/zsh/                →  ZDOTDIR — everything else lives here
  ├── .zshenv                →  real env vars (EDITOR, XDG_*, PATH, etc.)
  ├── .zprofile
  ├── .zshrc                 →  interactive config, aliases, plugins, prompt
  ├── aliases.zsh
  ├── bindings.zsh
  ├── fzf.zsh
  ├── plugins.zsh
  ├── prompt.zsh
  └── starship.toml
```

`install.sh` symlinks every file in this repo's `config/` into
`~/.config/zsh/`, so editing a file here and re-running `install.sh` is
enough to update your live shell — no manual copying.

**Do not create `~/.zshrc` directly.** If `~/.zshenv` correctly sets
`ZDOTDIR`, a `~/.zshrc` file living outside `$ZDOTDIR` is simply never read.
This bit us once already — see the `PATH` line below.

`~/bin` is added to `PATH` inside `config/.zshrc` itself (not appended by
`install.sh` at runtime), so it's version-controlled and won't silently
disappear.

### ⌨️ Keybindings & Shell Shortcuts
| Shortcut / Alias | Action |
|:---|:---|
| `Ctrl + T` | `fzf` file picker (includes hidden files) with `bat` syntax preview |
| `Ctrl + F` | `fzf` file picker (excludes hidden files) |
| `Ctrl + \` | Toggle `zsh-autosuggestions` on/off (ideal for clean screen recordings) |
| `↑` / `↓` | Substring history search (`zsh-history-substring-search`) |
| `ls` / `ll` / `la` / `tree` | `eza` with Nerd Font icons, git status column, and custom 256-color Cyberpunk palette |
| `gadog` / `glog` | Compact git graph (`--all --decorate --oneline --graph`) with auto-quit pager |
| `dotfiles` | Jump directly to this `my-mac-setup` repository |

### 🔧 Customization (Environment Overrides)
All scripts share a single configuration header in [`scripts/_styles.sh`](scripts/_styles.sh). Override any variable in `~/.config/zsh/.zshenv` without modifying the scripts:

| Variable | Default | Description |
|:---|:---|:---|
| `CODING_ROOT` | `~/Desktop/coding` | Root directory scanned by `new`, `pj`, `use`, `morning`, and `week` |
| `GITHUB_USER` | `cunhanina` | GitHub username used by `new` for Go modules and remote URLs |
| `WEATHER_CITY` | `Curitiba` | Location queried by `morning` via `wttr.in` |
| `NOTES_FILE` | `~/Desktop/notes.md` | Global task list file used by `note`, `morning`, and `week` |
| `JOURNAL_FILE` | `~/Desktop/journal.md` | Markdown journal file used by `journal` and `week` |

---

## 🆚 VS Code Config

**Path:** `vscode/settings.json`

* **Python:** Ruff formatter, format-on-save, organize imports, Pylance basic type checking.
* **Terminal:** Zsh, JetBrainsMonoNL Nerd Font, 10k scrollback.
* **UI:** No minimap, no breadcrumbs, sticky scroll, bracket pair guides.

### 📥 Install Settings
`./install.sh` automatically symlinks `vscode/settings.json` to `~/Library/Application Support/Code/User/settings.json`.

---

## 🚀 Installation

### Phase 1: The Foundation
```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Phase 2: Clone and Install
```bash
git clone https://github.com/cunhanina/my-mac-setup.git
cd my-mac-setup
./install.sh --bundle   # installs Brewfile packages, links scripts, ZDOTDIR & VS Code settings
gh auth login
```

`install.sh` is idempotent and does four things:
1. Symlinks everything in `scripts/` into `~/bin` (linking `_styles.sh` and `_use.sh` as sourced helpers).
2. Ensures `~/.zshenv` sets `ZDOTDIR=$HOME/.config/zsh`, then symlinks every file in `config/` into `~/.config/zsh/`.
3. Symlinks `vscode/settings.json` into `~/Library/Application Support/Code/User/settings.json`.
4. Configures macOS native screenshots to save cleanly to `~/Screenshots` (and optionally runs `brew bundle` when passed `--bundle`).

Restart your terminal (or run `exec zsh`) afterward. You should see the
Starship prompt (git branch, status icons) rendering — if you still see a
plain prompt, `ZDOTDIR` isn't being picked up; check `echo $ZDOTDIR` and
`ls -la ~/.config/zsh`.

### Phase 3: Raycast Extensions
```
Open Raycast Store and install:
  - Project Manager  (set root: ~/Desktop/coding)
  - Port Manager
  - Duplicate File Finder
  - File Organizer
Enable built-ins: Clipboard History, Window Management, Snippets
```

<div align="center">
  <sub>Built with ❤️ by <a href="https://github.com/cunhanina">cunhanina</a></sub>
</div>