#!/bin/sh
# Find hooks using old 'command -v' pattern instead of installed() function

grep -r "command -v" Hooks/ --include="*.sh"
