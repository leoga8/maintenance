#!/bin/zsh

# Run command function
run_cmd() {
	echo "$1"
	eval "$1"
	echo ""
}

# Start
echo "=== Manteinance start: $(eval "date") ==="

# Source ZSH
source ~/.zshrc

# Commands to run
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
)

# Run all commands in array
for cmd in "${cmds[@]}"; do
	run_cmd "$cmd"
done

# Done
echo "=== Manteinance done: $(eval "date") ==="