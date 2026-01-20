#!/bin/sh
# shellcheck source=/dev/null

linux() {
    rm -f ~/.local/bin/aws
    rm -f ~/.local/bin/aws_completer
    rm -rf ~/.local/awscli
}
