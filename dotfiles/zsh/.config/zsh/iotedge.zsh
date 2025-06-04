# iotedge

AZURE_UTILS=$HOME/iot/utilities/azure-utilities/azure-shell-functions.sh
if [ -f $AZURE_UTILS ]
then
    source $AZURE_UTILS
fi

export JUST_IIOT_PATH=$HOME/.config/just/justfile
