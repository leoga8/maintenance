#!/bin/zsh

# Run command function
run_cmd() {
	echo "[TX] :: $1\n[RX] ::"
	eval "$1"
}

# Start
echo "[INFO] :: Maintenance start: $(eval "date")"

# Check for OS
if [[ $(eval uname) == "Darwin" ]]; then
	# Mac OS
	cmds=(
		# Update Oh-My-ZSH
		"zsh $ZSH/tools/upgrade.sh"
		# Update Homebrew
		"brew update"
		# Show list of outdated items
		"brew outdated"
		# Show list of outdated casks
		"brew outdated --cask"
		# Upgrade items
		"brew upgrade"
		# Upgrade casks
		"brew upgrade --cask"
		# Upgrade casks which do not get upgraded with the above
		"brew upgrade --cask dbeaver-community"
		"brew upgrade --cask obsidian"
		"brew upgrade --cask iterm2"
		# Cleanup space
		"brew cleanup --prune=all"
		# Diagnose any issues to file
		"brew doctor"
		# Uninstall dependencies no longer needed
		"brew autoremove"
		# Upgrade pip
		"pip3 install --upgrade pip"
		# Outdated pip packages
		"pip3 list --outdated"
	)
else
	# Debian/Raspbian
	cmds=(
		# Update Oh-My-ZSH
		"yes | zsh $ZSH/tools/upgrade.sh"
		# Update
		"sudo apt-get update"
		# Upgrade
		"sudo apt-get upgrade -y"
		# Remove packages not needed
		"sudo apt autoremove -y"
		# Update Helix
		"yes | sudo snap refresh helix"
		# Upgrade pip - not needed since Debian manages Python packages through apt
		# "pip3 install --upgrade pip"
		# Outdated pip packages - not needed since Debian manages Python packages through apt
		# "pip3 list --outdated"
	)
fi

# Run all commands in array
for cmd in "${cmds[@]}"; do
	run_cmd "$cmd"
done

# Done
echo "[INFO] :: Maintenance done: $(eval "date")"
