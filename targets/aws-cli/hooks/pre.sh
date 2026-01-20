#!/bin/sh

linux() {
    curl -s "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    ./aws/install --bin-dir "$HOME/.local/bin/" --install-dir "$HOME/.local/awscli/" --update
    mkdir -p ~/.aws
}
