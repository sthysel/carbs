spacevimrc=~/.SpaceVim.d/

scrips:
	cd scripts; stow -t ~/.local/bin/ tools
	cd scripts; stow -t ~/.local/bin/ i3commands 

config:
	stow -t ~/.config config

profile:
	stow -t ~/ profile

spacevim: 
	mkdir -p ${spacevimrc}
	stow -t ${spacevimrc} spacevim

all: config scrips profile spacevim

