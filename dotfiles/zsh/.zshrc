# Install zplug if its not
ZPLUG_HOME=~/.zplug
if [[ ! -d ${ZPLUG_HOME} ]]
then
  git clone https://github.com/zplug/zplug ${ZPLUG_HOME}
  source ${ZPLUG_HOME}/init.zsh && zplug update --verbose
fi

source ${ZPLUG_HOME}/init.zsh

zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "plugins/vi-mode", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/z", from:oh-my-zsh
zplug "supercrabtree/k"
zplug "sthyselzsh/zsh-gayman"
# zplug "sthyselzsh/zsh-pydev"
zplug "sthyselzsh/zsh-vim"
zplug "sthyselzsh/zsh-proxy"
# needs to be last
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Load zplug
if ! zplug check --verbose
then
    zplug install
fi

# zsh flags
HISTFILE=~/.zhistory
HISTSIZE=20000
SAVEHIST=10000

setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt auto_cd

# config
DEFAULT_USER=$USER


zplug load

fpath+=~/.zfunc

# kitty auto complete
autoload -Uz compinit
compinit
kitty + complete setup zsh | source /dev/stdin

zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES

# load .env in every directory
eval "$(direnv hook zsh)"

# better cd
eval "$(zoxide init --cmd cd zsh)"
# marginally less gay prompt
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/brutal.json)"
# gay prompt
# eval "$(oh-my-posh --init --shell zsh)"

# . "$HOME/.cargo/env"
eval "$(uv generate-shell-completion zsh)"


# iotedge
AZURE_UTILS=~/iot/utilities/azure-utilities/azure-shell-functions.sh
if [ -f $AZURE_UTILS ]
then
    source $AZURE_UTILS
fi

[ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X" # boot up x-cmd.

# add Pulumi to the PATH
export PATH=$PATH:/home/thys/.pulumi/bin

# uv
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# . "$HOME/.local/bin/env"
