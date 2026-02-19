# CLAUDE.md — pack

## Project Overview

`pack` is a **single-file Bash script** that wraps system package managers behind a unified CLI. Zero dependencies, instant startup, uses `exec` for native passthrough.

## Architecture

The script (`pack`) is ~180 lines of Bash:

1. **`detect()`** — iterates a priority list of binaries, returns the first found
2. **Arg parsing** — `while/case` loop handles `-s`, `-i`, `-r`, `-d`, `-l`, `-m MGR`, `-h`
3. **`needs_sudo()`** — returns whether a manager needs sudo for install/update/remove
4. **`run()` / `run_plain()`** — `exec` wrappers; `run` prepends `sudo` when needed, `run_plain` never does (search, list, details)
5. **Dispatch** — nested `case` block: outer on manager, inner on action

### Manager priority (auto-detect)

| # | Binary | sudo | Notes |
|---|--------|------|-------|
| 1 | paru | no | Arch + AUR |
| 2 | yay | no | Arch + AUR |
| 3 | pacman | yes | Arch base |
| 4 | apt | yes | Debian/Ubuntu |
| 5 | dnf | yes | Fedora/RHEL |
| 6 | zypper | yes | openSUSE |
| 7 | apk | no | Alpine |
| 8 | xbps-install | yes | Void |

Any manager (including flatpak, snap) can be forced with `-m MGR`.

## CLI

```
pack                  → update all packages
pack -s QUERY         → search
pack -i PKG           → install
pack -r PKG           → remove
pack -d PKG           → package details
pack -l               → list installed packages
pack -m MGR ...       → force a specific manager
pack -h               → help
```

## Conventions

- `exec` replaces the shell process — stdin/stdout/stderr pass through naturally
- `set -euo pipefail` — fail fast
- Search, list, and details never use sudo
- No output parsing — the user sees raw package manager output

## Dev Commands

```bash
# Install to ~/.local/bin
make install

# System-wide install
sudo make install PREFIX=/usr/local

# Run directly
./pack -h
./pack -s firefox
./pack -i neovim
./pack -r neovim
./pack -d neovim
./pack -l
./pack

# Uninstall
make uninstall
```
