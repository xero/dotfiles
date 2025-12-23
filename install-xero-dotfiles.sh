#!/usr/bin/env bash
# install-xero-dotfiles.sh
# A safe-ish installer for xero's "classic" dotfiles (https://github.com/xero/dotfiles/tree/classic)
#
# Features:
# - clones the repo (or updates it) into ~/.dotfiles/xero-classic
# - detects distro (apt/pacman/dnf) and can install a sensible package list
# - installs GNU Stow (if needed) and uses it to symlink each package dir
# - backs up conflicting files to ~/.dotfiles-backup.TIMESTAMP
# - optional: install fonts found in the repo
# - optional: install zsh + offer to install oh-my-zsh
# - optional: build & install 2bwm from source (needs dev deps)
#
# Usage:
#   ./install-xero-dotfiles.sh [--repo URL] [--branch BRANCH] [--target HOME_DIR]
#                             [--skip-deps] [--yes] [--fonts] [--zsh] [--build-2bwm]
#
# Example:
#   ./install-xero-dotfiles.sh --yes --fonts --zsh
#
set -euo pipefail

##########################
### Configuration / defaults
##########################
DEFAULT_REPO="https://github.com/xero/dotfiles.git"
DEFAULT_BRANCH="classic"
DOTFILES_PARENT="$HOME/.dotfiles"
DOTFILES_DIR="$DOTFILES_PARENT/xero-classic"
STOW_TARGET="$HOME"
BACKUP_BASE="$HOME/.dotfiles-backup"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="${BACKUP_BASE}-${TIMESTAMP}"

AUTO_INSTALL_DEPS=false
ASSUME_YES=false
INSTALL_FONTS=false
INSTALL_ZSH=false
BUILD_2BWM=false
REPO="$DEFAULT_REPO"
BRANCH="$DEFAULT_BRANCH"

##########################
### Utilities
##########################
info()  { printf '\033[1;34m[INFO]\033[0m %s\n' "$*"; }
warn()  { printf '\033[1;33m[WARN]\033[0m %s\n' "$*"; }
error() { printf '\033[1;31m[ERROR]\033[0m %s\n' "$*" >&2; exit 1; }
confirm() {
  if $ASSUME_YES; then
    return 0
  fi
  printf "%s [y/N]: " "$1"
  read -r ans
  case "$ans" in
    [Yy]|[Yy][Ee][Ss]) return 0 ;;
    *) return 1 ;;
  esac
}

##########################
### Arg parsing
##########################
while [[ $# -gt 0 ]]; do
  case "$1" in
    --repo) REPO="$2"; shift 2;;
    --branch) BRANCH="$2"; shift 2;;
    --target) STOW_TARGET="$2"; shift 2;;
    --skip-deps) AUTO_INSTALL_DEPS=false; shift;;
    --install-deps) AUTO_INSTALL_DEPS=true; shift;;
    --yes|-y) ASSUME_YES=true; shift;;
    --fonts) INSTALL_FONTS=true; shift;;
    --zsh) INSTALL_ZSH=true; shift;;
    --build-2bwm) BUILD_2BWM=true; shift;;
    -h|--help) cat <<EOF
Usage: $0 [options]
Options:
  --repo URL        Dotfiles git URL (default: $DEFAULT_REPO)
  --branch BRANCH   Branch to checkout (default: $DEFAULT_BRANCH)
  --target DIR      Stow target (default: $HOME)
  --install-deps    Try to install packages automatically (requires sudo)
  --skip-deps       Don't attempt to install packages (default)
  --fonts           Install fonts found in the repo to ~/.local/share/fonts
  --zsh             Install zsh (and optionally oh-my-zsh)
  --build-2bwm      Try to build & install 2bwm from source (may need dev libs)
  --yes, -y         Assume yes to prompts
  -h, --help        Show this help
EOF
  exit 0;;
    *) error "Unknown argument: $1";;
  esac
done

##########################
### Distro detection & package lists
##########################
detect_distro() {
  if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    ID_LIKE=${ID_LIKE:-}
    ID=${ID:-}
    echo "$ID $ID_LIKE"
  else
    uname -s
  fi
}

DISTRO="$(detect_distro)"
info "Detected distro: $DISTRO"

# Base recommended packages — tweak as you like
# These are conservative suggestions based on the repo contents:
COMMON_PKGS=(git stow curl wget)
DEVEL_PKGS=(build-essential pkg-config make gcc automake autoconf)
X_PKGS=(xorg xinit feh rxvt-unicode compton tmux vim stalonetray mpd ncmpcpp cmus mutt fonts-fontconfig)
ZSH_PKGS=(zsh)

prepare_pkg_install_cmds() {
  case "$DISTRO" in
    *arch*|*manjaro*|ID=arch)
      PKG_MANAGER="pacman -S --noconfirm --needed"
      UPDATE_CMD="sudo pacman -Syu --noconfirm"
      PKGS=( "${COMMON_PKGS[@]}" "${DEVEL_PKGS[@]}" "${X_PKGS[@]}" "${ZSH_PKGS[@]}" )
      ;;
    *ubuntu*|*debian*|ID=ubuntu|ID=debian)
      PKG_MANAGER="sudo apt update && sudo apt install -y"
      UPDATE_CMD="sudo apt update && sudo apt upgrade -y"
      # apt package names differ: ensure common set but user may tweak
      PKGS=( git stow curl wget build-essential pkg-config make gcc automake autoconf \
             xorg xinit feh rxvt-unicode compton tmux vim stalonetray mpd ncmpcpp cmus mutt fonts-fontconfig zsh )
      ;;
    *fedora*|ID=fedora)
      PKG_MANAGER="sudo dnf install -y"
      UPDATE_CMD="sudo dnf upgrade --refresh -y"
      PKGS=( git stow curl wget @development-tools pkgconfig make gcc automake autoconf \
             xorg-x11-server-Xorg xorg-x11-xinit feh rxvt-unicode compton tmux vim stalonetray mpd ncmpcpp cmus mutt fontconfig zsh )
      ;;
    *)
      warn "Unsupported/unknown distro. I will not attempt to auto-install packages."
      PKG_MANAGER=""
      UPDATE_CMD=""
      PKGS=()
      ;;
  esac
}

prepare_pkg_install_cmds

##########################
### Clone / update repo
##########################
clone_or_update_repo() {
  mkdir -p "$DOTFILES_PARENT"
  if [[ -d "$DOTFILES_DIR/.git" ]]; then
    info "Repository already exists at $DOTFILES_DIR — fetching updates"
    git -C "$DOTFILES_DIR" fetch --all --prune
    git -C "$DOTFILES_DIR" checkout --quiet "$BRANCH" || git -C "$DOTFILES_DIR" checkout -b "$BRANCH" "origin/$BRANCH" || true
    git -C "$DOTFILES_DIR" pull --ff-only || true
  else
    info "Cloning $REPO (branch: $BRANCH) to $DOTFILES_DIR"
    git clone --depth 1 --branch "$BRANCH" "$REPO" "$DOTFILES_DIR"
  fi
}

##########################
### Install packages (optional)
##########################
install_packages() {
  if ! $AUTO_INSTALL_DEPS; then
    info "Auto-install of packages is disabled. Skipping package installation."
    return
  fi
  if [[ -z "$PKG_MANAGER" ]]; then
    warn "No package manager command prepared for your distro. Skipping package installation."
    return
  fi
  info "Attempting to install packages. This requires sudo and will run: $UPDATE_CMD"
  if ! confirm "Proceed to install packages?"; then
    warn "Skipping package installation."
    return
  fi
  # run update (if available)
  if [[ -n "$UPDATE_CMD" ]]; then
    info "Running update: $UPDATE_CMD"
    eval "$UPDATE_CMD"
  fi
  # install packages
  if [[ "${#PKGS[@]}" -gt 0 ]]; then
    info "Installing packages: ${PKGS[*]}"
    # split if apt update command included; PKG_MANAGER contains full command for apt
    if [[ "$PKG_MANAGER" == "sudo apt update && sudo apt install -y" ]]; then
      sudo apt update
      sudo apt install -y "${PKGS[@]}"
    else
      $PKG_MANAGER "${PKGS[@]}"
    fi
  fi
}

##########################
### Stow helpers
##########################
ensure_stow() {
  if ! command -v stow >/dev/null 2>&1; then
    warn "GNU stow not found."
    if $AUTO_INSTALL_DEPS && [[ -n "$PKG_MANAGER" ]]; then
      info "Attempting to install stow via package manager..."
      if [[ "$PKG_MANAGER" == "sudo apt update && sudo apt install -y" ]]; then
        sudo apt update && sudo apt install -y stow
      else
        $PKG_MANAGER stow
      fi
    else
      error "Please install 'stow' (package name: stow) and re-run this script."
    fi
  fi
}

gather_packages_to_stow() {
  # Stow each top-level directory in the dotfiles repo, excluding a few common files/dirs
  mapfile -t ALL_ENTRIES < <(cd "$DOTFILES_DIR" && printf '%s\n' * .[!.]* 2>/dev/null || true)
  PACKAGES=()
  for entry in "${ALL_ENTRIES[@]}"; do
    # ignore .git, README*, LICENSE, etc., and "bin" because repo contains bin/bin but that may be intentional
    case "$entry" in
      .git|README*|LICENSE*|install*|Makefile|.github|.gitignore) continue ;;
    esac
    # only add directories (packages) or files that start with a dot (some people stow dotfiles directly)
    if [[ -d "$DOTFILES_DIR/$entry" ]] || [[ "$entry" == .* ]] || [[ -f "$DOTFILES_DIR/$entry" ]]; then
      PACKAGES+=("$entry")
    fi
  done
  info "Detected packages to stow: ${PACKAGES[*]}"
}

backup_conflicts_and_stow() {
  mkdir -p "$BACKUP_DIR"
  ensure_stow
  # We'll run stow in dry-run to show planned operations per package.
  for pkg in "${PACKAGES[@]}"; do
    info "Dry-run stow for package: $pkg"
    # show what would be done
    DRY=$(stow --dir="$DOTFILES_DIR" --target="$STOW_TARGET" -nv "$pkg" 2>&1 || true)
    if [[ -z "$DRY" ]]; then
      info "Nothing to stow for package: $pkg"
      continue
    fi
    echo "-------- stow dry-run output for $pkg --------"
    printf '%s\n' "$DRY"
    echo "----------------------------------------------"
    if echo "$DRY" | grep -qi -E 'existing|overwrite|already exists|would create'; then
      warn "stow reported potential conflicts for $pkg."
      if confirm "Back up conflicting files and continue stowing $pkg?"; then
        # collect file paths mentioned by stow dry-run by extracting paths after "target:"
        # We will conservatively find absolute paths in the output
        mapfile -t conflict_paths < <(printf '%s\n' "$DRY" | grep -oE '/[^[:space:]]+' || true)
        for f in "${conflict_paths[@]}"; do
          # only move files/dirs within home
          if [[ "$f" == "$HOME"* && -e "$f" ]]; then
            target_backup="$BACKUP_DIR${f#$HOME}"
            mkdir -p "$(dirname "$target_backup")"
            info "Backing up $f -> $target_backup"
            mv -v "$f" "$target_backup"
          fi
        done
      else
        warn "Skipping stow of package $pkg due to conflicts (user declined backup)."
        continue
      fi
    fi
    info "Running stow for package: $pkg"
    stow --dir="$DOTFILES_DIR" --target="$STOW_TARGET" -v "$pkg"
    info "Finished stow for $pkg"
  done
}

##########################
### Fonts
##########################
install_fonts_from_repo() {
  # common locations in dotfiles: fonts/ , .fonts/ , themes/.themes/.../fonts
  FONT_TARGET="$HOME/.local/share/fonts"
  mkdir -p "$FONT_TARGET"
  found=false
  # search for typical font directories
  while IFS= read -r -d '' dir; do
    info "Installing fonts from $dir"
    found=true
    cp -v "$dir"/*.{ttf,otf,pcf,woff,woff2} "$FONT_TARGET" 2>/dev/null || cp -v "$dir"/* "$FONT_TARGET" 2>/dev/null || true
  done < <(find "$DOTFILES_DIR" -type d \( -iname "fonts" -o -iname ".fonts" -o -iname "ttf" -o -iname "otf" \) -print0 || true)

  if ! $found; then
    warn "No font directories found in the repo."
    return
  fi
  info "Refreshing font cache..."
  if command -v fc-cache >/dev/null 2>&1; then
    fc-cache -f -v "$FONT_TARGET" || true
  else
    warn "fc-cache not found; fonts copied but cache not updated."
  fi
  info "Fonts installed to $FONT_TARGET"
}

##########################
### zsh / oh-my-zsh
##########################
install_zsh_and_oh_my_zsh() {
  if ! command -v zsh >/dev/null 2>&1; then
    if $AUTO_INSTALL_DEPS && [[ -n "$PKG_MANAGER" ]]; then
      info "Installing zsh via package manager..."
      if [[ "$PKG_MANAGER" == "sudo apt update && sudo apt install -y" ]]; then
        sudo apt update && sudo apt install -y zsh
      else
        $PKG_MANAGER zsh
      fi
    else
      warn "zsh not installed. Please install it manually if you want zsh as your login shell."
      return
    fi
  fi
  if [[ "$SHELL" != "$(command -v zsh)" ]]; then
    if confirm "Change your login shell to zsh ($(command -v zsh))?"; then
      chsh -s "$(command -v zsh)" || warn "chsh failed; you may need to change your shell manually."
    fi
  fi
  if confirm "Install oh-my-zsh (recommended) into ~/.oh-my-zsh?"; then
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
      info "oh-my-zsh appears already installed at ~/.oh-my-zsh"
    else
      info "Installing oh-my-zsh (unattended)."
      # use the official installer but in unattended mode
      RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || warn "oh-my-zsh installer failed; you can install it manually."
    fi
  fi
}

##########################
### 2bwm build (optional)
##########################
build_and_install_2bwm() {
  if ! confirm "Attempt to clone, build and install 2bwm from source? (requires dev libs & sudo)"; then
    warn "Skipping 2bwm build."
    return
  fi
  info "Cloning 2bwm source to /tmp/2bwm-build"
  rm -rf /tmp/2bwm-build
  git clone --depth 1 https://github.com/irradiated/2bwm.git /tmp/2bwm-build
  pushd /tmp/2bwm-build >/dev/null || return
  info "Building 2bwm (make)"
  if ! make; then
    warn "make failed. You may be missing XCB/xlib development libraries. Please install them and try again."
    popd >/dev/null
    return
  fi
  info "Installing 2bwm (sudo make install)"
  sudo make install || warn "sudo make install failed. You may need to inspect errors."
  popd >/dev/null
  info "2bwm build process finished."
}

##########################
### Main flow
##########################
info "Starting xero dotfiles installer"
clone_or_update_repo
gather_packages_to_stow

install_packages

backup_conflicts_and_stow

if $INSTALL_FONTS; then
  install_fonts_from_repo
fi

if $INSTALL_ZSH; then
  install_zsh_and_oh_my_zsh
fi

if $BUILD_2BWM; then
  build_and_install_2bwm
fi

info "Done."
cat <<EOF

Summary:
- Dotfiles repo is at: $DOTFILES_DIR
- Stow target: $STOW_TARGET
- Backup (if any conflicts) saved to: $BACKUP_DIR

Notes & next steps:
- Review $BACKUP_DIR to restore anything if something moved unexpectedly.
- Check that your X session uses the config you expect (startx / login manager).
- If some programs (e.g. mpd/ncmpcpp, compton, 2bwm) need extra system packages, install them via your distro's package manager.
- If you want me to extend this script to install a curated package list for your distro, or to automatically enable systemd services (mpd), tell me your distro and I'll add it.

EOF