# dotfiles

This repo keeps all other dotfile trees I have in one repository as git
submodules.  That way all dotfiles are kept in a single ```~/dotfiles```.
I then use ```stow``` to link them out to .config or the like.

All config repos keeps the linkfarm gathered files in ```dot```, so a common 
``` $ stow -t ${HOME} dot ``` command works for all dotfile repos.

So for example compton's config is stored like so

``` 
compton
├── dot/
│   └── .config/
│       └── compton.conf
├── LICENSE
└── README.md

``` 

doing a ```stow -t ${HOME} dot``` in the compton folder now links everything in
dot/ to ${HOME}




