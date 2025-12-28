<div align="center">

# ⚡️ dotfiles / mac-setup

![macOS](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=apple&logoColor=white)
![Zsh](https://img.shields.io/badge/zsh-%23991199.svg?style=for-the-badge&logo=zsh&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![License](https://img.shields.io/badge/license-MIT-green?style=for-the-badge)

**The ultimate minimalist development environment.** Automated. Fast. Purple.

[The Stack](#-the-stack) • [Features](#-features) • [Installation](#-quick-start)

</div>

---

## 🖼️ The Look
<div align="center">
<img width="600" height="500" alt="image" src="https://github.com/user-attachments/assets/a0f44fbb-7d62-4311-9eb1-037c40c64c1d" />
</div>

---

## 💻 The Stack
The core technologies driving this environment.

| Component | Choice | Why? |
| :--- | :--- | :--- |
| **Shell** | `Oh My Zsh` | The industry standard for shell management. |
| **Theme** | `Powerlevel10k` | Instant startup, git status, and icons. |
| **Font** | `JetBrains Mono` | The best ligature support for coding. |
| **Colors** | `Catppuccin` | Soothing, high-contrast purple/pastel palette. |
| **Python** | `uv` | Replaces pip/poetry. 10x-100x faster package management. |

---

## ✨ Features
Custom scripts designed for "Lazy Productivity."

### 🛠 Workflow Automation
| Command | Function |
|:---|:---|
| `newpy` | **Project Generator.** Creates repo, installs venv, and pushes to GitHub instantly. |
| `pj` | **Teleporter.** Instantly jump between projects. |
| `save` | **Lazy Git.** `git add` + `commit` + `push` in one go. |
| `note` | **Context-Aware Tasks.** Detects if you are in a project or global scope. |

### ⚙️ System & Maintenance
| Command | Function |
|:---|:---|
| `health` | **Status Dashboard.** Checks battery, internet connection, and disk space. |
| `ports` | **Port Scanner.** Shows active listening ports (Great for Flask/Django). |
| `update` | **System Updater.** Updates Homebrew, Zsh, and tools in one click. |
| `clean` | **System Flush.** Clears DNS cache and frees up RAM. |
| `pyclean` | **Janitor.** Recursively nukes `__pycache__` and `.DS_Store`. |
| `organize` | **File Sorter.** Cleans up the Downloads folder automatically. |

---

## 🚀 Quick Start

### Phase 1: The Foundation
Perform these steps manually on a fresh Mac to prepare the environment.

**1. Install Command Line Tools**
```bash
xcode-select --install
```

**2. Install Homebrew**
```bash
/bin/bash -c "$(curl -fsSL [https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh](https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh))"
```

**3. Install Core Apps & Fonts**
```bash
brew install --cask iterm2 font-jetbrains-mono-nerd-font
brew install git gh bat glow uv
```

**4. Install Oh My Zsh**
```bash
sh -c "$(curl -fsSL [https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh](https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh))"
```

**5. Install Powerlevel10k**
```bash
git clone --depth=1 [https://github.com/romkatv/powerlevel10k.git](https://github.com/romkatv/powerlevel10k.git) ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

### Phase 2: The Automation
Now, clone this repo and let the installer configure your aliases, paths, and plugins.

```bash
# 1. Login to GitHub
gh auth login

# 2. Clone this repo
git clone [https://github.com/cunhanina/my-mac-setup.git](https://github.com/cunhanina/my-mac-setup.git)
cd my-mac-setup

# 3. Run the installer
./install.sh
```

<div align="center">
  <sub>Built with ❤️ by <a href="https://github.com/cunhanina">cunhanina</a></sub>
</div>
