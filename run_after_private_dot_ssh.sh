#!/bin/sh

chmod -R 700 ~/.ssh
chmod -R 700 ~/.ssh/*
chmod -R 600 ~/.ssh/*ed25519*
chmod -R 600 ~/.ssh/*dsa*
chmod -R 600 ~/.ssh/*rsa*
chmod -R 644 ~/.ssh/*.pub
