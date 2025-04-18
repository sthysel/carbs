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
    uv run pre-commit install

[doc('run pre-commit QA pipeline on all files')]
qa-all:
    uv run pre-commit run --all-files

[doc('Deploy CARBS')]
[script]
deploy limit="localhost" tags="all":
    echo "Limiting deployment to {{limit}}"
    uv run ansible-playbook -v \
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

[doc('install uv')]
[script]
install-uv:
    if ! not just have curl
    then
      curl -LsSf https://astral.sh/uv/install.sh | sh
    fi

[doc('install ansible using uv')]
[script]
install-ansible: install-uv
    uv sync
    uv run ansible-galaxy collection install community.general

[doc('bootstrap from scratch')]
bootstrap: install-ansible

[doc('Fix python argcomplete issue')]
[script]
fix-argcomplete:
    pip install argcomplete
    activate-global-python-argcomplete
