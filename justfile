python_version := env_var_or_default("PYTHON_VERSION", "3.12.2")

functions := '''
  set -euxo pipefail
  function have {
	  command -v "$1" &>/dev/null
  }

'''

# list all available recipes
[private]
help:
  @just --list

# install pre-commit hooks
qa-install-pre-commit-hooks:
  poetry run pre-commit install

# run pre-commit QA pipeline on all files
qa-all:
	poetry run pre-commit run --all-files

# deploy CARBS
deploy limit="localhost" tags="all":
  #!/usr/bin/env bash
  {{functions}}

  echo "Limiting deployment to {{limit}}"

  poetry run ansible-playbook \
    -v \
    --user $USER \
    --inventory inventories/ \
    --limit ${limit} \
    --tags ${tags} \
    provision.yml

# link in the dotfiles
dotfiles:
	stow -v --dir ./dotfiles --target ~ --dotfiles .

# remove all dangling symlinks
remove-danglinks:
	find ~/ -xtype l -exec rm {} \;

# install yay if not already installed
install-yay:
  #!/usr/bin/env bash
  {{functions}}

  if ! have yay
  then
    echo "Installing yay"
    # first we install yay with packman
    sudo pacman -S --needed base-devel git
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
    # and now we use yay to install yay, so everything is gay
    yay -S --noconfirm yay
  fi

# install pyenv using yay
install-pyenv: install-yay
  #!/usr/bin/env bash
  {{functions}}

  if ! have pyenv
  then
    echo "Installing pyenv"
    yay -S --noconfirm pyenv
  fi

# ensure pyenv is initialized correctly
initialize-pyenv: install-pyenv
  #!/usr/bin/env bash
  {{functions}}

  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  if have pyenv
  then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
  else
    echo "cannot find pyenv"
  fi

# install preferred Python version {{ python_version }} using pyenv
install-python: initialize-pyenv
  #!/usr/bin/env bash
  {{functions}}

  if ! pyenv versions | grep {{python_version}}
  then
    pyenv install {{python_version}}
    echo "Installing {{python_version}} using pyenv"
  else
    echo "{{python_version}}" already installed
  fi
  # this is the new user python
  pyenv global {{python_version}}

# install pipx using the user Python
install-pipx: install-python
  #!/usr/bin/env bash
  {{functions}}

  echo "Installing pipx"
  python -m pip install --user pipx
  python -m pipx ensurepath
  if [ -f "$HOME/.bashrc" ]
  then
    source "$HOME/.bashrc"
  elif [ -f "$HOME/.zshrc" ]
  then
    source "$HOME/.zshrc"
  else
    echo "No .bashrc or .zshrc file found. Please source the appropriate file manually."
  fi

# install poetry using pipx
install-poetry: install-pipx
  #!/usr/bin/env bash
  {{ functions }}

  echo "Installing poetry using pipx"
  # if have pipx && ! have poetry
  if have pipx && ! $(pipx list | grep -q 'package poetry')
  then
    pipx install poetry
  else
    echo "poetry is already installed"
  fi

# install ansible using poetry
install-ansible: install-poetry
  poetry install
  poetry run ansible-galaxy collection install community.general

# bootstrap from scratch
bootstrap: install-ansible

# Fix python argcomplete issue
fix-argcomplete:
  pip install argcomplete
  activate-global-python-argcomplete
