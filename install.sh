#!/bin/bash
CONFIG_PATH="$HOME/.config"
SHELL_PATH="$HOME/.config/bashelle"
BACKUP_PATH="$SHELL_PATH/backup"
CONFIG_FOLDERS=('hypr' 'kitty' 'matugen' 'wallpapers' 'quickshell') 

before_install() {
  echo -e "This script will install the following packages (yay or paru needed):"
  
  while IFS= read -r line; do
     echo "$line" 
  done < <(grep -Ev "^#|^$" pkglist)
  
  echo ""
  read -p "Do you agree? (default: yes) [y/n]: " confirm
  confirm=${confirm:-y}

  if [[ "${confirm,,}" == "y" ]]; then
    return 0
  fi
  
  echo -e "Installation has been aborted.\n"
  exit 1
}


install_dependencies() {
  local pkgs=$(grep -vE '^#|^$' pkglist | xargs)
  
  if [ -n "$pkgs" ]; then
    if command -v yay > /dev/null; then 
      yay -S --needed $pkgs
      return 0
    fi

    if command -v paru > /dev/null; then
      paru -S --needed $pkgs
      return 0
    fi

    echo "paru or yay cannot be found, the installation can't continue."
    exit 1
  fi
}

install_dotfiles() {
  echo "Installing dotfiles..."
  echo "The installer will create $SHELL_PATH if not exist."

  echo "Some scripts inside $SHELL_PATH/quickshell/scripts needs your permission to be executed."
  read -p "Grant permissions? (default: yes) [y/n]: " confirm
  confirm=${confirm:-y}

  if [[ "${confirm,,}" == "n" ]]; then
    echo "WARN: Some features won't work properly."
  else 
    chmod +x "./quickshell/scripts/change_theme.sh"
  fi 

  if [[ ! -d "$SHELL_PATH" ]]; then
    mkdir "$SHELL_PATH"
  fi



  mkdir -p "$SHELL_PATH/backup"
  cp -rp hypr kitty matugen quickshell wallpapers "$SHELL_PATH"
  
  for folder in "${CONFIG_FOLDERS[@]}"; do
    if [[ -d "$CONFIG_PATH/$folder" ]]; then
      echo "Creating backup for $folder"
      cp -r "$CONFIG_PATH/$folder" "$SHELL_PATH/backup"
      rm -rf "$CONFIG_PATH/$folder"
    fi

    echo "Creating symlink for $SHELL_PATH/${folder}"
    ln -s "$SHELL_PATH/$folder" "$CONFIG_PATH"
  done
}

post_install() {
  echo "Running Post install commands..."
  pgrep "awww-daemon" > /dev/null || awww-daemon& > /dev/null
  matugen image "$SHELL_PATH/wallpapers/wallpaper.jpg" --source-color-index 0  > /dev/null
  awww img "$SHELL_PATH/wallpapers/wallpaper.jpg"& > /dev/null
  
  kill -SIGUSR1 $(pgrep kitty)
  hyprctl reload

  if pgrep "qs" > /dev/null; then
    qs kill && qs > /dev/null&
  else qs > /dev/null&
  fi
}


if before_install; then
  install_dependencies
  install_dotfiles
  post_install

  echo "Installation has been completed"
  echo "Check $CONFIG_PATH/quickshell/shell.json for customization!"
fi
