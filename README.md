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
│   ├── hypr/                    # Hyprland Lua window manager configs & scripts
│   ├── caelestia/               # Caelestia shell, variables, and user overrides
│   ├── fish/                    # Fish shell configuration & aliases
│   ├── foot/                    # Foot terminal emulator config
│   ├── starship.toml            # Starship cross-shell prompt configuration
│   ├── fuzzel/                  # Fuzzel application launcher config
│   ├── uwsm/                    # Universal Wayland Session Manager config
│   ├── btop/                    # Btop resource monitor config & themes
│   ├── fastfetch/               # Fastfetch system info layout
│   ├── cava/                    # Cava audio visualizer config & shaders
│   ├── micro/                   # Micro text editor keybinds & settings
│   ├── yazi/                    # Yazi terminal file manager config & themes
│   ├── Thunar/                  # Thunar file manager shortcuts & custom actions
│   ├── gtk-3.0/ & gtk-4.0/      # GTK themes and custom CSS styling
│   ├── qt5ct/, qt6ct/, qtengine/# Qt theme engine configs
│   ├── fcitx5/                  # Fcitx5 input method configuration
│   ├── kdeglobals               # KDE global appearance settings
│   ├── mimeapps.list            # Default application associations
│   └── user-dirs.dirs           # XDG user directory mappings
├── Pictures/Wallpapers/         # Complete wallpaper image collection
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
git clone --bare https://github.com/CVK0406/dotfiles.git $HOME/.dotfiles
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout
```

> **Note:** If `dotfiles checkout` reports conflicts due to existing default config files:
> - To force overwrite default configs with your dotfiles:
>   ```fish
>   dotfiles checkout -f
>   ```
> - Or to backup conflicting default files before checking out:
>   ```fish
>   dotfiles checkout 2>&1 | grep -E "^\s+\." | awk '{print $1}' | xargs -I{} mv {} {}.bak
>   dotfiles checkout
>   ```


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
