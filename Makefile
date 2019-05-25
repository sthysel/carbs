install-scrips:
	cd scripts; stow -t ~/.local/bin/ tools
	cd scripts; stow -t ~/.local/bin/ i3commands 

install-config:
	stow -t ~/.config config

install-profile:
	stow -t ~/ profile

