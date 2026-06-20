<div align="center">

# ⚡️ dotfiles / mac-setup

![macOS](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=apple&logoColor=white)
![Zsh](https://img.shields.io/badge/zsh-%23991199.svg?style=for-the-badge&logo=zsh&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![VSCode](https://img.shields.io/badge/VS%20Code-007ACC?style=for-the-badge&logo=visualstudiocode&logoColor=white)
![Raycast](https://img.shields.io/badge/Raycast-FF6363?style=for-the-badge&logo=raycast&logoColor=white)

**The ultimate minimalist development environment.** Automated. Fast. Purple.

[The Stack](#-the-stack) • [Features](#-features) • [VS Code](#-vs-code-config) • [Installation](#-installation)

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

---

## ✨ Features

### 🛠 Workflow Automation (Terminal)
| Command | Function |
|:---|:---|
| `newpy` & `newcpp` | **Project Generator.** Creates repo, installs venv, pushes to GitHub. |
| `save` | **Lazy Git.** `git add` + `commit` + `push` with conflict detection. |
| `note` | **Context-Aware Tasks.** Detects git root for project scope vs global. |
| `use` | **venv Activator.** Activates `.venv` at git root or by project name. |
| `morning` | **Daily Dashboard.** Git status, calendar, tasks, weather, quote. |
| `week` | **Weekly Review.** Commit counts + completed tasks across all projects. |

### ⚙️ System & Maintenance (Terminal)
| Command | Function |
|:---|:---|
| `health` | **Status Dashboard.** Battery, RAM, disk, connectivity, dev stack. |
| `update` | **System Updater.** Homebrew + uv + Oh My Zsh in one command. |
| `clean` | **System Flush.** DNS + RAM purge + brew cleanup. App-specific mode via `clean <AppName>`. |
| `pyclean` | **Janitor.** Recursively nukes `__pycache__`, `.ruff_cache`, `.mypy_cache`, etc. |

### 🚀 Raycast Script Commands
Located in `raycast-commands/`. Install via Raycast → Settings → Extensions → Script Commands → Add Directories.

| Command | Replaces | Mode |
|:---|:---|:---|
| `Health` | `health` (terminal) | fullOutput |
| `Morning` | `morning` (terminal) | fullOutput |
| `Clean System` | `clean` no-arg path | fullOutput |
| `Week` | `week` (terminal) | fullOutput |
| `Note Add` | `note "text"` for global tasks | silent |

### 🔌 Raycast Extensions (install from Store)
| Extension | Replaces |
|:---|:---|
| Project Manager | `pj` script |
| Port Manager | `ports` script |
| Duplicate File Finder | `dupes` script |
| File Organizer | `organize` script + launchd |
| Clipboard History | — (new, built-in) |
| Window Management | — (new, built-in) |
| Snippets | — (new, built-in) |

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
brew install git gh bat glow uv fzf fd eza zoxide ripgrep starship
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Phase 2: Clone and Install
```bash
gh auth login
git clone https://github.com/cunhanina/my-mac-setup.git
cd my-mac-setup
./install.sh
```

### Phase 3: Raycast Setup
```
1. Open Raycast → Settings → Extensions → Script Commands
2. Click "Add Directories" → select raycast-commands/ from this repo
3. Open Raycast Store and install:
   - Project Manager  (set root: ~/Desktop/coding)
   - Port Manager
   - Duplicate File Finder
   - File Organizer
4. Enable built-ins: Clipboard History, Window Management, Snippets
```

<div align="center">
  <sub>Built with ❤️ by <a href="https://github.com/cunhanina">cunhanina</a></sub>
</div>
