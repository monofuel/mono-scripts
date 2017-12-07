#!/bin/bash
set -euo pipefail

# accepts NODE_TOOLS as a space-separated list of additional packages to install globally
# eg: export NODE_TOOLS="webpack typescript nodemon"

NODE_TOOLS="${NODE_TOOLS:-}"

bash ./tools.bash

if [[ $UID != 0 ]]; then
	echo 'please run as root'
	exit -1
fi

# makes an assumption if node is installed that npm is also installed
if [ -x "$(command -v node)" ]; then
	echo 'node already installed'
	exit
else
	curl -sL https://deb.nodesource.com/setup_9.x | bash -
	apt-get install -y nodejs
fi

if ! [[ -e "$NODE_TOOLS" ]]; then
	echo "installing additional npm packages: $NODE_TOOLS"

fi