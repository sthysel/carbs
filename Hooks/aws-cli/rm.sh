#!/bin/sh
# shellcheck source=/dev/null
. ../../lib/lib.sh

linux() {
    rm -f ~/.local/bin/aws
    rm -f ~/.local/bin/aws_completer
    rm -rf ~/.local/awscli
}
