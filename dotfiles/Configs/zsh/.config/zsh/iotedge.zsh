# shellcheck shell=bash
# iotedge

AZURE_UTILS=$HOME/iot/utilities/azure-utilities/azure-shell-functions.sh
if [ -f "$AZURE_UTILS" ]
then
    # shellcheck source=/dev/null
    source "$AZURE_UTILS"
fi

# export BHP_DEV_TOOLKIT="$HOME/code/gitlab.com/bhp-cloudfactory/iiot/utilities/iiot-utils/justfile"
export BHP_DEV_TOOLKIT="$HOME/.config/just/justfile"
