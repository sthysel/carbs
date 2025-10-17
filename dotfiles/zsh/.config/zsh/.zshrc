# install zinit if its not where I expect it to be
if [[ ! -f ${HOME}/.local/share/zinit/zinit.git/zinit.zsh ]]
then
  mkdir -p ${HOME}/.local/share/zinit
  git clone https://github.com/zdharma-continuum/zinit.git ${HOME}/.local/share/zinit/zinit.git
fi
source ${HOME}/.local/share/zinit/zinit.git/zinit.zsh

# Self-manage zinit itself
zinit light zdharma-continuum/zinit

# Oh My Zsh base framework
zinit ice depth=1
zinit light ohmyzsh/ohmyzsh

# Individual OMZ plugins by path
zinit ice pick"plugins/vi-mode/vi-mode.plugin.zsh"
zinit light ohmyzsh/ohmyzsh
zinit ice pick"plugins/git/git.plugin.zsh"
zinit light ohmyzsh/ohmyzsh
zinit ice pick"plugins/z/z.plugin.zsh"
zinit light ohmyzsh/ohmyzsh

# Other plugins
zinit light supercrabtree/k
zinit light zsh-users/zsh-syntax-highlighting

# Zsh options and environment setup
setopt auto_cd
DEFAULT_USER=$USER
fpath+=~/.zfunc

# Completions (only need to call compinit once)
autoload -Uz compinit bashcompinit
compinit
bashcompinit

# kitty
kitty + complete setup zsh | source /dev/stdin
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES

eval "$(direnv hook zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/brutal.json)"
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
eval $(thefuck --alias)

# load any secrets
[ -f "$HOME/.secrets.sh" ] && source "$HOME/.secrets.sh"

# Add Pulumi to path
export PATH=$PATH:/home/thys/.pulumi/bin

# load all the other config files
for f in $ZDOTDIR/*.zsh; do [ -f "$f" ] && source "$f"; done
