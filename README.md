# CARBS (Version 0.3)

In which you will find Chad Arch Random Bootstrap Scripts, and also dots.

The dependencies and once-of stuff is done by Ansible, that's things like
packages, some unique config for some of my machines, see [ansible](/ansible).

Dotfiles are kept in `~/carbs` and then linked out to `~/.config/`, `~/.local/`
and so on. That way its easy to keep config in git and push/pull as I like in
`~/carbs` when config is updated or I find a new thing to play with.

![Shot](pics/screenshot1.jpg)

The base OS and dot install is seperate.

So generally you will:

- Install arch from USB
- Run ansible over the fresh install to add all the tools and scripts.

It makes sense to clone carbs on the target machine and run the ansible
playbook locally as the repo also includes the dots. I want to tune the dots
and have them available on my other machines so it does not make sense to copy
them into place, rather link them into place and keep them under version
control in the carbs repo.


# Install Arch

Install Arch on target. While there install

- openssh, enable it
- networkmanager, or similar
- neovim
- sudo, enable wheel allowances using `EDITOR=vim visudo`

Add user thys `# useradd -m -G wheel -s /bin/zsh thys`, set the password

Nice, now

 - install the ssh public key: `ssh-copy-id thys@10.0.0.69`
 - run ansible: `$ play.sh 10.0.0.69`


# Install CARBS dots

Everything is installed using `stow`. The `Makefile` knows how to use it, so
use that like so: `make -B all`, thats all.

So in `stow` parlance most directories here are `installation images`, `stow` links these into
the appropiate target directories noted in the Makefile.

# stow shenanigans

So `scripts` is a directory with usefull scrips. To link `scripts/tools` into
`~/.local/bin` where it belongs, do `cd scripts; stow -t ~/.local/bin/ tools`, or just
`make scripts`, which will do it for both `i3commands` and `tools`.

So this tree will be linked into `~/.local/bin`

```zsh
├── scripts/
│   ├── i3commands/
│   │   ├── clipboarder*
│   │   ├── hover*
│   │   ├── i3dropdownspawn*
│   │   ├── i3resize*
│   │   ├── pornmode*
│   │   ├── prompt*
│   │   ├── samedir*
│   │   └── winresize*
│   ├── tools/
│   │   ├── avi2mp4.sh*
│   │   └── mp4togif.sh*
│   └── README.md

```

# Notes

- https://wiki.archlinux.org/index.php/NVIDIA_Optimus for Lenovo W540 with Nvidia

# Desktop fed on moist and delightfull CARBS

![CARBS](pics/iregretnothing.jpeg)
