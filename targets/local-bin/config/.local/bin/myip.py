#!/bin/env python
# cheatsheet: Show system IP address

import socket


def get_ip():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)
    s.connect(("<broadcast>", 0))
    return s.getsockname()[0]


print(get_ip())
