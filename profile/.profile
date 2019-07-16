if [ "$0" = "/usr/sbin/lightdm-session" -a "$DESKTOP_SESSION" = "i3" ]
then
    export $(gnome-keyring-daemon -s)
fi

export TERMINAL=kitty
export BROWSER=google-chrome-stable
export VISUAL=emacsclient
export EDITOR=emacsclient

# python
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

# java
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd_hrgb'

# CUDA bullshit, fuck you nvidia
export CUDA_HOME=/opt/cuda/
export NUMBAPRO_CUDA_DRIVER=/usr/lib64/libcuda.so
export NUMBAPRO_LIBDEVICE=/opt/cuda/nvvm/libdevice/
export NUMBAPRO_NVVM=/opt/cuda/nvvm/lib64/libnvvm.so
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/cuda/targets/x86_64-linux/lib/:/lib/x86_64-linux-gnu 

# pipx bs
export PATH=$PATH:/opt/cuda/bin/:~/.local/bin/:~/.local/bin

# Created by `userpath` on 2019-07-08 04:50:59
PATH="$PATH:/home/thys/.local/bin"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
