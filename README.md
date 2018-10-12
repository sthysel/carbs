# dotfiles

This repo keeps all other dotfile trees in one repository as git
submodules.  That way all dot are kept in a single `~/dotfiles` and you know
what you got. Pick the things you need and install only them.

I did it this way because I did not like having unrelated config in the same
repo, and people generally only care about zsh or bash or ranger and they
already have their own config the way they like it for the tools they care
about. This way I can share specific dotfiles with coleages and friends and
still keep everyhing I need together.


## install

Clone this repo and do a `$ make update` to get the latest submodules.

Then use `stow` to link those you need out to where the tool expects its config
to be: typically `~.config/`.

All config repos keeps the linkfarm gathered files in a `dot` directory, so a
common ` $ stow -t ${HOME} dot ` command works for all dotfile repos.

For example compton's config is stored like so

```zsh
compton
├── dot/
│   └── .config/
│       └── compton.conf
├── LICENSE
└── README.md
``` 

doing a `stow -t ${HOME} dot` in the compton folder now links everything in
`dot/` to `${HOME}`


`$make update` fetches master branches of submodules.


