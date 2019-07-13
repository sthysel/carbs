spacevimrc=~/.SpaceVim.d/
tools=-d ./scripts -t ~/.local/bin/ tools
scripts=-d ./scripts -t ~/.local/bin/ i3commands 
config=-t ~/.config config
profile=-t ~/ profile

.PHONY: tools
.PHONY: scripts 
.PHONY: config 
.PHONY: profile 
.PHONY: spacevim
.PHONY: all
.PHONY: rm-all

tools:
	mkdir -p ~/.local/bin/
	stow ${tools} 

rm-tools:
	stow -D ${tools} 

scripts:
	mkdir -p ~/.local/bin/
	stow ${scripts}

rm-scripts:
	stow -D ${scripts}

config:
	mkdir -p ~/.config/
	stow ${config}

rm-config:
	stow -D ${config}

profile:
	stow ${profile}

rm-profile:
	stow -D ${profile}

spacevim: 
	mkdir -p ${spacevimrc}
	stow -t ${spacevimrc} spacevim

rm-spacevim:
	rm -fr ${spacevimrc}

all: tools scripts config profile spacevim

rm-all: rm-tools rm-scripts rm-config rm-profile rm-spacevim

