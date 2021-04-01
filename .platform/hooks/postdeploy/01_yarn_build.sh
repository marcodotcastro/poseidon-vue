#!/usr/bin/env bash
set -xe

cd /var/app/current
sudo yarn install
sudo yarn build