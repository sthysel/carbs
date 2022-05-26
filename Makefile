scripts=-t ~/.local/bin/ scripts
config=-t ~/.config config

.PHONY: scripts
.PHONY: config
.PHONY: spacevim
.PHONY: all
.PHONY: rm-all

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

spacevim:
	mkdir -p ${spacevimrc}
	stow -t ${spacevimrc} spacevim

rm-spacevim:
	rm -fr ${spacevimrc}

init:
	git submodule update --init --recursive

update:
	git pull --recurse-submodules

all: init scripts config spacevim

rm-all: rm-scripts rm-config rm-spacevim
