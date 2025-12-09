# install zinit if its not where I expect it to be
if [[ ! -f ${HOME}/.local/share/zinit/zinit.git/zinit.zsh ]]
then
  mkdir -p ${HOME}/.local/share/zinit
  git clone https://github.com/zdharma-continuum/zinit.git ${HOME}/.local/share/zinit/zinit.git
fi
source ${HOME}/.local/share/zinit/zinit.git/zinit.zsh

# Zsh options and environment setup
setopt auto_cd
DEFAULT_USER=$USER

# Setup completion styles
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES

# Initialize completions NOW before anything else
autoload -Uz compinit
compinit

# Load OMZ snippets
zinit snippet OMZP::vi-mode
zinit snippet OMZP::git

# Other plugins
zinit light supercrabtree/k
zinit light zsh-users/zsh-syntax-highlighting

# kitty
kitty + complete setup zsh | source /dev/stdin

eval "$(direnv hook zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
eval $(thefuck --alias)

# load any secrets
[ -f "$HOME/.secrets.sh" ] && source "$HOME/.secrets.sh"

# Add Pulumi to path
export PATH=$PATH:/home/thys/.pulumi/bin

# load all the other config files
for f in $ZDOTDIR/*.zsh; do [ -f "$f" ] && source "$f"; done
