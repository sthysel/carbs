set unstable := true
set dotenv-load := true
set positional-arguments := true
set script-interpreter := ['bash', '-euo', 'pipefail']

python_version := env_var_or_default("PYTHON_VERSION", "3.12.2")

[private]
help:
    @just --list

[doc("Check if {{cmd}}'s exists on the path")]
[private]
[script]
have *cmd:
    for c in {{ cmd }}
    do
        echo -n "Checking for $c"
        command -v $c >/dev/null 2>&1 || { echo >&2 "....Required $c not found. Aborting."; exit 1; }
        echo "....found"
        done

[doc('install pre-commit hooks')]
qa-install-pre-commit-hooks: (have ('poetry pre-commit'))
    poetry run pre-commit install

[doc('run pre-commit QA pipeline on all files')]
qa-all:
    poetry run pre-commit run --all-files

[doc('Deploy CARBS')]
[script]
deploy limit="localhost" tags="all":
    echo "Limiting deployment to {{limit}}"
    poetry run ansible-playbook -v \
    --user $USER \
    --inventory inventories/ \
    --limit ${limit} \
    --tags ${tags} \
    provision.yml

[doc('link in the dotfiles')]
dotfiles:
    stow -v --dir ./dotfiles --target ~ --dotfiles .

[doc('remove all dangling symlinks')]
remove-danglinks:
    find ~/ -xtype l -exec rm {} \;

[doc('install yay if not already installed')]
[script]
install-yay:
    if ! just have  yay
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

[doc('install pyenv using yay')]
[script]
install-pyenv: install-yay
    if ! just have  pyenv
    then
        echo "Installing pyenv"
        yay -S --noconfirm pyenv
    fi

[doc('ensure pyenv is initialized correctly')]
[script]
initialize-pyenv: install-pyenv
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    if just have  pyenv
    then
        eval "$(pyenv init --path)"
        eval "$(pyenv init -)"
    else
        echo "cannot find pyenv"
    fi

[doc('install preferred Python version {{ python_version }} using pyenv')]
[script]
install-python: initialize-pyenv
    if ! pyenv versions | grep {{python_version}}
    then
      pyenv install {{python_version}}
      echo "Installing {{python_version}} using pyenv"
    else
      echo "{{python_version}}" already installed
    fi
    # this is the new user python
    pyenv global {{python_version}}

[doc('install pipx using the user Python')]
[script]
install-pipx: install-python
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

[doc('install poetry using pipx')]
[script]
install-poetry: install-pipx
    echo "Installing poetry using pipx"
    if just have  pipx && ! $(pipx list | grep -q 'package poetry')
    then
      pipx install poetry
    else
      echo "poetry is already installed"
    fi

[doc('install ansible using poetry')]
[script]
install-ansible: install-poetry
    poetry install
    poetry run ansible-galaxy collection install community.general

[doc('bootstrap from scratch')]
bootstrap: install-ansible

[doc('Fix python argcomplete issue')]
[script]
fix-argcomplete:
    pip install argcomplete
    activate-global-python-argcomplete
