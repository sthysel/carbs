# Comfy Arch


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


