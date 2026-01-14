# shellcheck shell=bash
# History file configuration
HISTFILE=~/.zhistory
HISTSIZE=10000          # Commands to remember in current session
export SAVEHIST=10000   # Commands to save to history file

# History options
setopt EXTENDED_HISTORY         # Save timestamps
setopt INC_APPEND_HISTORY       # Write immediately, not on shell exit
setopt SHARE_HISTORY            # Share history between sessions
setopt HIST_IGNORE_DUPS         # Don't record duplicates
setopt HIST_IGNORE_ALL_DUPS     # Delete old duplicates
setopt HIST_FIND_NO_DUPS        # Don't show duplicates in search
setopt HIST_IGNORE_SPACE        # Don't record commands starting with space
setopt HIST_SAVE_NO_DUPS        # Don't write duplicates to file
setopt HIST_REDUCE_BLANKS       # Remove extra whitespace

# show it all
alias history='history 1'
