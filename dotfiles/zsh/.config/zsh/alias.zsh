# general aliases

alias ls='lsd'
alias l='ls -l'
alias ll="ls -lahF"
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias tree='tree -CFa -I ".mypy_cache|.git|__pycache__|.venv" --dirsfirst'

# force password prompt ssh, for when keys are broken or weird
alias pssh='ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no'

# pandoc markdown to rst
alias md2rst='pandoc --from=markdown --to=rst --output=README.rst README.md'

# emotive package management
alias yeet="yay -Rcs"
