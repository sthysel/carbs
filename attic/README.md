# docker-alias

In my dotfiles I have a alias.d directory that contains files like these:

```
alias.d/
├── common.alias
├── docker.alias -> /home/thys/playpen/docker-alias/docker.alias
├── dvcs.alias
└── vim.alias
```

In the bashrc the folowing function loads all .alias files from ${ALIAS_HOME}


```
# source all alias and function files in ${ALIAS_HOME} ending in .alias
ALIAS_HOME=${HOME}/dotfiles/alias.d
if [ -d ${ALIAS_HOME} ]
then
  for a in $(find -L ${ALIAS_HOME} -type f -name "*.alias")
  do
    echo "Loading $a"
    source $a
  done
fi
```

docker.alias is linked into ${ALIAS_HOME} and gets sourced by basrc/zshrc when the terminal is initialised.
