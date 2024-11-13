#!/bin/zsh

# Run command function
run_cmd() {
	echo "[TX] :: $1\n[RX] ::"
	eval "$1"
}

# Start
echo "[INFO] :: Maintenance start: $(eval "date")"

# Source ZSH
source ~/.zshrc

# Check for OS
if [[ $(eval uname) == "Darwin" ]]; then
	# Mac OS
	cmds=(
		# Update Oh-My-ZSH
		"omz update"
		# Update Homebrew
		"brew update"
		# Show list of outdated items
		"brew outdated"
		# Upgrade items
		"brew upgrade"
		# Cleanup space
		"brew cleanup --prune=all"
		# Diagnose any issues to file
		"brew doctor"
		# Uninstall dependencies no longer needed
		"brew autoremove"
	)
else
	# Debian/Raspbian
	cmds=(
		# Update Oh-My-ZSH
		"omz update"
		# Update
		"sudo apt-get update"
		# Upgrade
		"sudo apt-get upgrade"
		# Remove packages not needed
		"sudo apt autoremove"
	)
fi

# Run all commands in array
for cmd in "${cmds[@]}"; do
	run_cmd "$cmd"
done

# Done
echo "[INFO] :: Maintenance done: $(eval "date")"
