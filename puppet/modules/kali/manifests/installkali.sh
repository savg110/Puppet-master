#!/bin/bash
export DEBIAN_FRONTEND=noninteractive # This sets the frontend to non-interactive mode

apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" kali-linux-full # This installs the kali-linux-full metapackage and keeps manually modified configuration but non-modified configuration is updated, if needed
