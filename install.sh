#!/bin/bash
SHELL_VERSION="1.0.0"
CONFIG_PATH="$HOME/.config"
SHELL_PATH="$CONFIG_PATH/bashelle"
STATE_PATH="$HOME/.local/state"

prompt() {
  local text="$1"
  local default="$2"
  default=${default:-y}

  [[ "$default" == "y" ]] && def="yes" || def="no"

  while true; do
    echo "$text"
    read -p "(default: $def) [y/n]: " confirm
    confirm=${confirm:-$default}
    confirm=${confirm,,}
    
    if [[ "$confirm" != "y" && "$confirm" != "n" ]]; then
      echo -e "Try again.\n"
      continue
    fi

    [[ "$confirm" == "y" ]] && echo "yes" && return 0
    [[ "$confirm" == "n" ]] && echo "no" && return 1
  done
}

add_path() {
  local new_path="$1"
  [[ ":$PATH:" == *":$new_path:"* ]] && return 0
    
  case "$SHELL" in
  */fish) fish -c "fish_add_path $new_path" ;;
  */bash) echo "export PATH=$new_path:\$PATH" >> $HOME/.bashrc ;;
  */zsh)  echo "export PATH=$new_path:\$PATH" >> $HOME/.zshrc ;;
  *)      echo "export PATH=$new_path:\$PATH" >> $HOME/.profile ;;
  esac
  return 0
}

before_install() {
  cd "$(dirname "$BASH_SOURCE")"
  
  if [[ -d "$SHELL_PATH" ]]; then 
   ! prompt "'bashelle/' folder detected. Reinstall?" "n" && exit 1
  fi

  echo -e "\n• BEFORE INSTALL"
  echo -e "This script will install the following packages (yay or paru needed):"
  
  while IFS= read -r line; do
     echo -e " - $line" 
  done < <(grep -Ev "^#|^$" pkglist)  
  echo ""
  
  prompt "Do you agree?" && return 0
 
  echo -e "Installation aborted.\n"
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
  qs kill > /dev/null
  clear
  echo -e "\n• DOTFILES INSTALLATION"

  if [[ ! -d "$SHELL_PATH" ]]; then
    mkdir "$SHELL_PATH"
  fi
  
  echo
  local backup_dir="$SHELL_PATH/backup/installer-$(date +"%Y%m%d")_$(uuidgen)"
  mkdir -p "$backup_dir"

  for folder in "matugen" "quickshell" "hypr"; do
    if [[ -d "$CONFIG_PATH/$folder" ]]; then
      echo "Creating backup for '$folder/'"
      cp -rL "$CONFIG_PATH/$folder" "$backup_dir/$folder"
      rm -rf "$CONFIG_PATH/$folder"
    fi

    echo -e "Installing '$folder/'"
    cp -r "./$folder" "$SHELL_PATH/"
    ln -s "$SHELL_PATH/$folder" "$CONFIG_PATH/"
  done

  echo "✔ Done"
}

post_install() {
  echo -e "\n• POST INSTALL COMMANDS"
  
  if [[ "$XDG_CURRENT_DESKTOP" == "Hyprland" ]]; then
    pgrep awww-daemon > /dev/null || awww-daemon &> /dev/null &
    local wallpapers_folder="$SHELL_PATH/wallpapers"
    mkdir -p "$wallpapers_folder"    
    echo "Wallpapers folder has been created:"
    echo "  -> $wallpapers_folder"
    echo -e "You can change it later, don't worry :D\n"

    if prompt "Do you want to add default wallpapers?"; then
      cp wallpapers/* "$wallpapers_folder"
      awww img "$wallpapers_folder/wallpaper.jpg"
      matugen image -q "$wallpapers_folder/wallpaper.jpg" --source-color-index 0 &> /dev/null
    else matugen color hex -q "#33ccff"
    fi
    
    echo
    echo "Some clean arch installs do not have xdg user dirs updated"
    echo -e "See: https://specifications.freedesktop.org/basedir/latest/\n"
    prompt "Run -> 'xdg-user-dirs-update' now?" && xdg-user-dirs-update

    hyprctl -q reload
    qs -d > /dev/null
  else
    matugen color hex -q "#33ccff"
  fi
  
  mkdir -p "$STATE_PATH/bashelle"
  echo "$SHELL_VERSION" > "$STATE_PATH/bashelle/version"
}

cli_installation() {
  local git_url="https://api.github.com/repos/Bashelle/bashelle-cli/releases/latest"
  local release_status=$(curl -s -o /dev/null -w "%{http_code}" "$git_url")
  if [[ "$release_status" != "200" ]]; then
    echo "Couldn't find releases. ($release_status)"
    echo "Bashelle-cli couldn't be installed"
    return 1
  fi

  if [[ -f "$HOME/.local/bin/bashelle" ]]; then
   ! prompt "Bashelle-cli is already installed. Reinstall?" && return 1
  fi

  clear
  echo -e "\n• CLI INSTALLATION"
  echo "  Bashelle has a command line interface."
  echo
  echo "  What it does? "
  echo "    - Manage Bashelle versions"
  echo "    - Create backups"
  echo "    - Call quickshell shortcuts"
  echo 
  echo "  Whether you decide to install or not"
  echo "  it won't affect functionality"
  echo
  echo "See: https://github.com/Bashelle/bashelle-cli"
  echo

  if prompt "Install Bashelle CLI? (recommended)"; then
    local bin_url=$(curl -s "$git_url" | jq -r ".assets[0].browser_download_url")
    local tmp="/tmp/bashelle"
    mkdir -p "$tmp"
    
    echo "Downloading: $bin_url"
    curl -L "$bin_url" -o "$tmp/bscli.sh"
    chmod +x "$tmp/bscli.sh"
    mkdir -p "$HOME/.local/bin"
    
    [[ ":$PATH:" != *":$HOME/.local/bin:"* ]] &&
      prompt "$HOME/.local/bin is not in your PATH. Add now? (recommended)" && \
      add_path "$HOME/.local/bin"
    
    mv "$tmp/bscli.sh" "$HOME/.local/bin/bashelle"
    echo
    return 0
  fi
  echo
  return 1
}

echo "▗▄▄▖  ▗▄▖  ▗▄▄▖▗▖ ▗▖▗▄▄▄▖▗▖   ▗▖   ▗▄▄▄▖";
echo "▐▌ ▐▌▐▌ ▐▌▐▌   ▐▌ ▐▌▐▌   ▐▌   ▐▌   ▐▌   ";
echo "▐▛▀▚▖▐▛▀▜▌ ▝▀▚▖▐▛▀▜▌▐▛▀▀▘▐▌   ▐▌   ▐▛▀▀▘";
echo "▐▙▄▞▘▐▌ ▐▌▗▄▄▞▘▐▌ ▐▌▐▙▄▄▖▐▙▄▄▖▐▙▄▄▖▐▙▄▄▖";
echo "v$SHELL_VERSION                         ";
echo "                                        ";

trap 'echo -e "\nInstallation aborted."; exit 1' SIGINT
ARGS="$1"

case "$ARGS" in
"-cli")
  cli_installation && \
    echo -e "• Bashelle-cli has been installed in $HOME/.local/bin/bashelle"
;;
*)
  if before_install; then
    install_dependencies
    install_dotfiles
    post_install
    cli_installation && \
      echo -e "• Bashelle-cli has been installed in $HOME/.local/bin/bashelle"

    echo "• Backups are stored in $SHELL_PATH/backups/"
    echo -e "\n Bashelle '$SHELL_VERSION' has been installed!"
    echo "Have fun :)"
  fi
;;
esac
