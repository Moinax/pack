# pack — Universal Package Manager

A single-file Bash script that wraps your system's package manager behind a unified CLI. Zero dependencies, instant startup, native passthrough via `exec`.

## Prerequisites

- Bash
- One of the supported package managers installed on your system

## Installation

```bash
# Install to ~/.local/bin
make install

# System-wide install
sudo make install PREFIX=/usr/local
```

## Usage

```bash
# Update all packages
pack

# Search for a package
pack -s firefox

# Install a package
pack -i neovim

# Show help
pack -h

# Force flatpak or snap
pack --flatpak -s firefox
pack --flatpak -i org.mozilla.firefox
pack --snap -s firefox
```

## Supported Package Managers

Auto-detected (first found wins):

| # | Binary         | sudo | Distribution          |
|---|----------------|------|-----------------------|
| 1 | `paru`         | no   | Arch + AUR            |
| 2 | `yay`          | no   | Arch + AUR            |
| 3 | `pacman`       | yes  | Arch Linux            |
| 4 | `apt`          | yes  | Debian, Ubuntu        |
| 5 | `dnf`          | yes  | Fedora, RHEL, CentOS  |
| 6 | `zypper`       | yes  | openSUSE              |
| 7 | `apk`          | no   | Alpine Linux          |
| 8 | `xbps-install` | yes  | Void Linux            |

Opt-in via flags:

| Flag         | Binary    | sudo |
|--------------|-----------|------|
| `--flatpak`  | `flatpak` | no   |
| `--snap`     | `snap`    | yes  |

## Uninstall

```bash
make uninstall
```
