#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status.
set -u  # Treat unset variables as an error.

PYTHON_VERSION=${PYTHON_VERSION:-3.12.2}

function have {
  command -v "$1" &>/dev/null
}

# install yay if not already installed
install_yay() {
    if ! have yay
    then
        # first we install yay with packman
        sudo pacman -S --needed base-devel git
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si
        cd ..
        rm -rf yay
        # and now we use yay to install yay, so everything is yay
        yay -S --noconfirm yay
    else
        echo "yay is already installed"
    fi
}


# install pyenv using yay
install_pyenv() {
    if ! have pyenv
    then
        yay -S --noconfirm pyenv
    else
        echo "pyenv is already installed"
    fi
}

# ensure pyenv is initialized correctly
initialize_pyenv() {
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    if have pyenv
    then
        eval "$(pyenv init --path)"
        eval "$(pyenv init -)"
    else
        echo "cannot find pyenv"
    fi
}

# install preferred Python version using pyenv
install_python_version() {
    if ! pyenv versions | grep -q "$PYTHON_VERSION"
    then
        pyenv install $PYTHON_VERSION
    fi
    # this is the new user python
    pyenv global $PYTHON_VERSION
}

# install pipx using the user Python
install_pipx() {
    if ! have pipx
    then
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

    else
        echo "pipx is already installed"
    fi
}

# install poetry using pipx
install_poetry() {
    if ! have poetry && have pipx
    then
        pipx install poetry
    else
        echo "poetry is already installed"
    fi
}

install_ansible() {
    poetry install
	  poetry run ansible-galaxy collection install community.general
}

bootstrap() {
    echo "Bootstrap CARBS"
    install_yay
    install_pyenv
    initialize_pyenv
    install_python_version
    install_pipx
    install_poetry
    install_ansible
    echo "CARBS Bootstrap completed successfully!"
}
