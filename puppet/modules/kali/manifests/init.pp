#!/bin/bash
export DEBIAN_FRONTEND=noninteractive # This sets the frontend to non-interacti$
apt-get update -q # This updates the repository list
apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="$