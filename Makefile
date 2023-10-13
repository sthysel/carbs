# Makefile for managing carbs using stow

# Define variables for script and config paths
SCRIPTS_PATH = ~/.local/bin/
CONFIG_PATH = ~/.config/
SPACEVIMRC_PATH = ~/.SpaceVim.d/

# Phony targets do not represent files
.PHONY: scripts rm-scripts config rm-config spacevim rm-spacevim init update all rm-all

# Create the scripts directory and stow scripts
scripts:
	@mkdir -p $(SCRIPTS_PATH)
	@stow -t $(SCRIPTS_PATH) scripts || echo "Stowing scripts failed."

# Unstow scripts
rm-scripts:
	@stow -D -t $(SCRIPTS_PATH) scripts || echo "Unstowing scripts failed."

# Create the config directory and stow config
config:
	@mkdir -p $(CONFIG_PATH)
	@stow -t $(CONFIG_PATH) config || echo "Stowing config failed."

# Unstow config
rm-config:
	@stow -D -t $(CONFIG_PATH) config || echo "Unstowing config failed."

# Create the SpaceVim configuration directory and stow spacevim
spacevim:
	@mkdir -p $(SPACEVIMRC_PATH)
	@stow -t $(SPACEVIMRC_PATH) spacevim || echo "Stowing SpaceVim config failed."

# Remove the SpaceVim configuration directory
rm-spacevim:
	@read -p "Are you sure you want to remove the SpaceVim config? [y/N] " confirm; \
	[ $$confirm == "y" ] && rm -fr $(SPACEVIMRC_PATH) || echo "Removal cancelled."

# Initialize git submodules
init:
	@git submodule update --init --recursive || echo "Git submodule initialization failed."

# Update the repository and submodules
update:
	@git pull --recurse-submodules || echo "Git update failed."

# Run all the stow commands
all: init scripts config spacevim

# Remove all stowings
rm-all: rm-scripts rm-config rm-spacevim

