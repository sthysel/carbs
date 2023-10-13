#zmodload zsh/zprof

export GDK_SCALE=2
export GDK_DPI_SCALE=0.5

export TERMINAL=kitty
export TERM=xterm-kitty

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
zplug "sthyselzsh/zsh-pydev"
zplug "sthyselzsh/zsh-vim"
zplug "sthyselzsh/zsh-proxy"
zplug "MichaelAquilina/zsh-autoswitch-virtualenv"
# needs to be last
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Install packages that have not been installed yet
if ! zplug check --verbose
then
    printf "Install? [y/N]: "
    if read -q
    then
        echo
        zplug install
    else
        echo
    fi
fi


# zsh flags
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt auto_cd

# config
DEFAULT_USER=$USER

HISTFILE=~/.zhistory
HISTSIZE=1200
SAVEHIST=1000

ZSH_THEME='powerlevel10k/powerlevel10k'

zplug load

fpath+=~/.zfunc
# kitty auto complete
autoload -Uz compinit
compinit
kitty + complete setup zsh | source /dev/stdin

zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES

# pyenv
eval "$(pyenv init -)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

export PATH="$HOME/.poetry/bin:$PATH"

eval $(thefuck --alias)
export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
# starship
# eval "$(starship init zsh)"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/home/thys/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# JINA_CLI_BEGIN

## autocomplete
if [[ ! -o interactive ]]; then
    return
fi

compctl -K _jina jina

_jina() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(jina commands)"
  else
    completions="$(jina completions ${words[2,-2]})"
  fi

  reply=(${(ps:
:)completions})
}

# session-wise fix
ulimit -n 4096
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# JINA_CLI_END

MANPAGER="nvim +Man!"
MANWIDTH=999

export OPENAI_API_KEY=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
eval "$(pyenv virtualenv-init -)"
