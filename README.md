# 🌌 CachyOS + Hyprland + Caelestia Dotfiles

Personal dotfiles for a modern, fluid, and dynamic desktop setup built on **CachyOS**, **Hyprland** (Lua configuration format), and **Caelestia Shell**.

---

## 🎨 Overview & Tech Stack

| Component | Choice / Details |
|---|---|
| **OS** | [CachyOS](https://cachyos.org/) (Arch Linux derivative) |
| **Compositor** | [Hyprland](https://hyprland.org/) `v0.56+` (using `hyprland.lua` runtime) |
| **Desktop Environment** | [Caelestia Shell](https://github.com/caelestia-dots/caelestia) (`caelestia-cli`, `caelestia-shell`) |
| **Shell** | [Fish Shell](https://fishshell.com/) (`~/.config/fish/config.fish`) |
| **Prompt & Tools** | Starship, Zoxide, Eza, Direnv |
| **Package Export** | Managed via `pacman` and `paru` package lists |

---

## 📁 Repository Structure

```text
.
├── .config/
│   ├── hypr/
│   │   ├── hyprland.lua         # Main Hyprland Lua entry point
│   │   ├── variables.lua        # Environment & system variables
│   │   ├── xdph.conf            # XDG Desktop Portal Hyprland config
│   │   ├── config/              # Modular Hyprland configs (binds, rules, inputs, etc.)
│   │   ├── hyprland/            # Component configuration modules
│   │   └── utils/               # Lua utility functions & JSON parser
│   ├── caelestia/
│   │   ├── hypr-user.lua        # Caelestia user Hyprland overrides
│   │   ├── hypr-vars.lua        # Caelestia Hyprland keybind variables
│   │   ├── shell.json           # Caelestia shell & UI configuration
│   │   ├── user-config.fish     # Caelestia Fish shell integration
│   │   └── monitors/            # Display monitor setup
│   └── fish/
│       └── config.fish          # Fish shell aliases, prompts, & integration
└── dotfiles-export/
    ├── pkglist.txt              # Native official repository packages
    └── aur-pkglist.txt          # Explicitly installed AUR packages
```

---

## 🚀 Bootstrapping a New Machine

### 1. Base System & Caelestia Installation

Ensure Hyprland and Caelestia dependencies are installed on your fresh CachyOS/Arch system:

```bash
sudo pacman -S --needed hyprland xdg-desktop-portal-hyprland xdg-desktop-portal-gtk ttf-jetbrains-mono-nerd git

# Install Caelestia via AUR helper (paru or yay)
paru -S caelestia-cli
caelestia install
```

### 2. Clone & Checkout Dotfiles

Clone this repository using the bare Git repository method to restore your configuration files and package lists:

```fish
git clone --bare git@github.com:CVK0406/dotfiles.git $HOME/.dotfiles
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout
```

> **Note:** If checkout reports conflicts due to default generated files, back them up and checkout again:
> ```fish
> dotfiles checkout 2>&1 | grep -E "\s+\." | awk '{print $1}' | xargs -I{} mv {} {}.bak
> dotfiles checkout
> ```

### 3. Restore Software Packages

Now that `dotfiles-export/` has been checked out into your home directory, restore your packages:

```bash
# Official repository packages
sudo pacman -S --needed - < ~/dotfiles-export/pkglist.txt

# AUR packages
paru -S --needed - < ~/dotfiles-export/aur-pkglist.txt
```

### 4. Wallpapers & Scheme Generation


Restore your wallpaper collection and generate your initial dynamic Caelestia color scheme:

```fish
caelestia wallpaper -f ~/Pictures/Wallpapers/<your-favorite-wallpaper>
caelestia scheme set -n dynamic
hyprctl reload
```

---

## 🔄 Daily Workflow & Synchronization

This repository includes custom Fish shell aliases for easy management:

- `dotfiles`: Interacting with the bare Git repository (e.g. `dotfiles status`, `dotfiles add <file>`).
- `dots-sync`: One-command sync that updates package lists, stages changes, commits, and pushes to remote.

### Syncing Changes:
```fish
dots-sync
```

### Pulling Updates on Another Machine:
```fish
dotfiles pull
dotfiles checkout
```
