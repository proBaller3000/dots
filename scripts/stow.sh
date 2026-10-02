#!/bin/bash

# Stow a package: removes the config it manages from $HOME, then stows the dotfiles version

stow_package() {

  local package_name="$1"
  local dotfiles_dir="$(git rev-parse --show-toplevel)"

  printf "\nstow $package_name script\n"
  echo "==============="

  # Unstow prior stow-created links first, so the removal below never descends into the repo
  (cd "$dotfiles_dir" && stow -D "$package_name")

  # Remove any real config the package manages, derived from its layout: $HOME + package-relative path
  local file target
  while IFS= read -r file; do
    target="$HOME/${file#"$dotfiles_dir/$package_name"/}"
    if [ -e "$target" ]; then
      echo "Removing $target..."
      rm -f "$target"
    fi
  done < <(find "$dotfiles_dir/$package_name" -type f)

  # Stow the config
  echo "Stowing $package_name from $dotfiles_dir..."
  (cd "$dotfiles_dir" && stow "$package_name")
  echo "✓ Stowed successfully"

  echo "Done!"

}
