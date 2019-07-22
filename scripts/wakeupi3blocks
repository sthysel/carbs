#!/bin/sh

# i3 forgets to send wakeup after suspend
bar=i3blocks

kill -SIGCONT $(ps -ef | grep ${bar} | awk '{print $2}')
