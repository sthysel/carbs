#!/bin/sh

echo "Installing YubiKey tools and smartcard stack..."
yay_install \
    pcsclite \
    ccid \
    pcsc-tools \
    yubikey-manager \
    yubikey-personalization \
    yubico-authenticator-bin \
    pam-u2f \
    libfido2
