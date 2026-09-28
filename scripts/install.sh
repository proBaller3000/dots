#!/usr/bin/env bash
set -euo pipefail

# -----------------------------
# Packages
# -----------------------------

OFFICIAL_PACKAGES=(
  git
  git-lfs
  uv
  base-devel
  yazi
  zsh
  lazygit
  # godot
  godot-mono
  dotnet-sdk
  stow
  eza
  fzf
  zoxide
  zsh-autosuggestions
  zsh-syntax-highlighting
  starship
  alacritty
  ttf-jetbrains-mono-nerd
  btop
  fastfetch
  chromium
  wl-clipboard
  typst
  ttf-fira-sans
  otf-font-awesome
  tree-sitter-cli
  rustup
  docker
  docker-compose
  git-delta
  direnv
  playerctl
  bluetui
  noto-fonts-emoji
)

AUR_PACKAGES=(
  noctalia-git
  # unityhub
  # blender-bin
)

# -----------------------------
# Functions
# -----------------------------

install_official() {
  echo "Installing official packages..."
  sudo pacman -S --needed --noconfirm "${OFFICIAL_PACKAGES[@]}"
}

install_yay() {
  if ! command -v yay &>/dev/null; then
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    pushd /tmp/yay >/dev/null
    makepkg -si --noconfirm
    popd >/dev/null
  else
    echo "yay already installed, skipping..."
  fi
}

install_aur() {
  echo "Installing AUR packages..."
  yay -S --needed --noconfirm "${AUR_PACKAGES[@]}"
}

set_zsh_default() {
  if [[ "$SHELL" != "/bin/zsh" ]]; then
    echo "Setting zsh as default shell..."
    chsh -s /bin/zsh
  else
    echo "zsh already default shell, skipping..."
  fi
}

setup_docker() {
  if ! systemctl is-enabled docker &>/dev/null; then
    echo "Enabling docker service..."
    sudo systemctl enable docker
  else
    echo "docker service already enabled, skipping..."
  fi
  if ! systemctl is-active docker &>/dev/null; then
    echo "Starting docker service..."
    sudo systemctl start docker
  else
    echo "docker service already running, skipping..."
  fi
  if ! groups "$USER" | grep -q docker; then
    echo "Adding $USER to docker group..."
    sudo usermod -aG docker "$USER"
  else
    echo "$USER already in docker group, skipping..."
  fi
}

setup_git_delta() {
  git config --global core.pager delta
  git config --global interactive.diffFilter 'delta --color-only'
  git config --global delta.navigate true
  git config --global delta.light false
}

# -----------------------------
# Main
# -----------------------------

install_official
install_yay
install_aur
setup_docker
set_zsh_default
setup_git_delta

curl -fsSL https://opencode.ai/install | bash
curl -fsSL https://herdr.dev/install.sh | sh
rustup default stable

echo "All done."
