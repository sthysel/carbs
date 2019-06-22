spacevimrc=~/.SpaceVim.d/

.PHONEY: scripts config profile spacevim

scripts:
	stow -d ./scripts -t ~/.local/bin/ tools
	stow -d ./scripts -t ~/.local/bin/ i3commands 

config:
	stow -t ~/.config config

profile:
	stow -t ~/ profile

spacevim: 
	mkdir -p ${spacevimrc}
	stow -t ${spacevimrc} spacevim

all: config scrips profile spacevim

