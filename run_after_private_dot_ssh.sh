#!/bin/sh

chmod -R 700 ~/.ssh
chmod -R 700 ~/.ssh/*
chmod -R 644 ~/.ssh/*.pub
chmod -R 600 ~/.ssh/*id_ed25519
chmod -R 600 ~/.ssh/*_idecdsa
