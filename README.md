<div align="center">

# ⚡️ dotfiles / mac-setup

![macOS](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=apple&logoColor=white)
![Zsh](https://img.shields.io/badge/zsh-%23991199.svg?style=for-the-badge&logo=zsh&logoColor=white)
![Go](https://img.shields.io/badge/go-00ADD8?style=for-the-badge&logo=go&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![VSCode](https://img.shields.io/badge/VS%20Code-007ACC?style=for-the-badge&logo=visualstudiocode&logoColor=white)
![Raycast](https://img.shields.io/badge/Raycast-FF6363?style=for-the-badge&logo=raycast&logoColor=white)

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
| `new <lang> <name>` | **Project Generator.** `py`, `cpp`, or `go`. Scaffolds, git-inits, pushes a private GitHub repo. |
| `save` | **Lazy Git.** `git add` + `commit` + `push`, detects if remote is ahead before pushing. |
| `note` | **Context-Aware Tasks.** Detects git root for project scope vs global (`~/Desktop/notes.md`). |
| `pj` | **Project Jumper.** `fzf`-search projects under `~/Desktop/coding` (git repos, up to 3 levels deep), opens a new iTerm tab `cd`'d into the pick. |
| `use [name\|off]` | **venv Activator.** Sourced via alias — see note below. |
| `week [last]` | **Weekly Review.** Commit counts + completed tasks across all projects. |
| `morning [--quick]` | **Daily Dashboard.** Weather, git status across projects, today's calendar, pending tasks, a quote. `--quick` skips network calls. Requires `brew install icalbuddy` for calendar events. |

> **`use` must stay an alias, not a binary.** It calls `source .venv/bin/activate`
> inside your *current* shell — running it as a subprocess would activate the
> venv in a child process and do nothing to your terminal. `install.sh` does
> not symlink it into `~/bin` for this reason; `config/aliases.zsh` defines
> `alias use='source ~/bin/use'` instead. Don't "fix" this by adding it back
> to the symlink loop.

### ⚙️ System & Maintenance (Terminal)
| Command | Function |
|:---|:---|
| `health` | **Status Dashboard.** Battery, RAM, disk, connectivity, dev stack. |
| `update` | **System Updater.** Homebrew + uv + Oh My Zsh in one command. |
| `clean` | **System Flush.** DNS flush + RAM purge + `brew cleanup`. |
| `pyclean` | **Janitor.** Recursively nukes `__pycache__`, `.ruff_cache`, `.mypy_cache`, etc. |

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

---

## 🆚 VS Code Config

**Path:** `vscode/settings.json`

* **Python:** Ruff formatter, format-on-save, organize imports, Pylance basic type checking.
* **Terminal:** Zsh, JetBrainsMonoNL Nerd Font, 10k scrollback.
* **UI:** No minimap, no breadcrumbs, sticky scroll, bracket pair guides.

### 📥 Install Settings
```bash
mkdir -p ~/Library/Application\ Support/Code/User
cp vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
```

---

## 🚀 Installation

### Phase 1: The Foundation
```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install --cask raycast font-jetbrains-mono-nerd-font
brew install git gh bat glow uv go fzf fd eza zoxide ripgrep starship icalbuddy
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Phase 2: Clone and Install
```bash
gh auth login
git clone https://github.com/cunhanina/my-mac-setup.git
cd my-mac-setup
./install.sh
```

`install.sh` does two things:
1. Symlinks everything in `scripts/` (except `use`, which is alias-only —
   see [Shell Config](#-shell-config-zdotdir)) into `~/bin`.
2. Ensures `~/.zshenv` sets `ZDOTDIR=$HOME/.config/zsh`, then symlinks
   every file in `config/` into `~/.config/zsh/`.

It's idempotent — safe to re-run any time after editing a script or config
file to relink it.

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