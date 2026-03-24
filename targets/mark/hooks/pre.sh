#!/bin/sh

# mark - sync markdown to Atlassian Confluence
# https://github.com/kovetskiy/mark

arch() {
    yay_install go
    go install github.com/kovetskiy/mark@latest
}
