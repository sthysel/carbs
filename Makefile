install-scrips:
	cd scripts; stow -t ~/.local/bin/ tools
	cd scripts; stow -t ~/.local/bin/ statusbar

install-config:
	stow -t ~/.config config

