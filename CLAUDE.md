# CLAUDE.md — pack

## Project Overview

`pack` is a **single-file Bash script** that wraps system package managers behind a unified CLI. Zero dependencies, instant startup, uses `exec` for native passthrough.

## Architecture

The script (`pack`) is ~150 lines of Bash:

1. **`detect()`** — iterates a priority list of binaries, returns the first found
2. **Arg parsing** — `while/case` loop handles `-s`, `-i`, `-h`, `--flatpak`, `--snap`
3. **`needs_sudo()`** — returns whether a manager needs sudo for install/update
4. **`run()` / `run_plain()`** — `exec` wrappers; `run` prepends `sudo` when needed, `run_plain` never does (search)
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

Opt-in via flags: `--flatpak` (no sudo), `--snap` (sudo).

## CLI

```
pack                  → update all packages
pack -s QUERY         → search
pack -i PKG           → install
pack -h               → help
pack --flatpak ...    → force flatpak
pack --snap ...       → force snap
```

## Conventions

- `exec` replaces the shell process — stdin/stdout/stderr pass through naturally
- `set -euo pipefail` — fail fast
- Search never uses sudo
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
./pack

# Uninstall
make uninstall
```
