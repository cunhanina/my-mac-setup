<div align="center">

# ⚡️ dotfiles / mac-setup

![macOS](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=apple&logoColor=white)
![Zsh](https://img.shields.io/badge/zsh-%23991199.svg?style=for-the-badge&logo=zsh&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![License](https://img.shields.io/badge/license-MIT-green?style=for-the-badge)

**The ultimate minimalist development environment.** Automated. Fast. Purple.

[Installation](#-installation) • [Features](#-features) • [Structure](#-structure)

</div>

---
## 🚀 Installation

Set up a fresh Mac in **under 30 seconds** with one command:

```bash
git clone [https://github.com/cunhanina/my-mac-setup.git](https://github.com/cunhanina/my-mac-setup.git)
cd my-mac-setup
./install.sh
```

## ✨ Features

### 🛠 Automation Tools
| Command | Function |
|:---|:---|
| `newpy` | **Project Generator.** Creates repo, venv, and pushes to GitHub instantly. |
| `pj` | **Teleporter.** Instantly jump between projects. |
| `save` | **Lazy Git.** `git add` + `commit` + `push` in one go. |
| `focus` | **Deep Work.** Opens coding playlists, docs, and blocks distractions. |

### 🧠 Productivity
| Command | Function |
|:---|:---|
| `note` | **Context-Aware Tasks.** Detects if you are in a project or global scope. |
| `organize` | **Auto-Cleaner.** Sorts Downloads folder into Images, Code, PDFs. |
| `pyclean` | **Janitor.** Recursively nukes `__pycache__` and `.DS_Store`. |

---

## 📂 Structure

```text
my-mac-setup/
├── config/
│   ├── zshrc.backup       # Configuration for Z Shell
│   └── p10k.zsh          # Powerlevel10k Theme Config
├── scripts/
│   ├── newpy             # Python project generator
│   ├── note              # Task manager
│   ├── focus             # Work mode activator
│   └── ...
├── install.sh            # The "One-Click" installer
└── README.md
```

## 🎨 Aesthetics
- **Shell:** Oh My Zsh + Powerlevel10k
- **Theme:** Catppuccin Macchiato / Dracula
- **Font:** MesloLGS NF
- **Plugins:** `git`, `zsh-autosuggestions`, `syntax-highlighting`

---

<div align="center">
  <sub>Built with ❤️ by <a href="https://github.com/cunhanina">cunhanina</a></sub>
</div>
