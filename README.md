# CARBS

Chad Arch Random Bootstrap Scripts, and also dots.

![CARBS](pics/iregretnothing.jpeg)

## Install

Everything is installed using `stow`. The `Makefile` knows how to use it, so
use that like so: `make all`


## But how ?

So `scrips` is directory with usefull scrips, to link it into `~/.local/bin`
where it belongs do `stow -t ~/.local/bin/ scripts`, or just `make scripts`

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

This will link all the scripts in `scripts` into `~/.local/bin`. You are now done.

![Shot](pics/screenshot1.jpg)


