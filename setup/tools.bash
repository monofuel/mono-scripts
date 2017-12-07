#!/bin/bash
set -euo pipefail

TOOLS=""

# commands where the package matches the executable
BASIC=( "git" "make" "wget" "curl" "tmux")

# add tools that need to be installed to TOOLS
for tool in "${BASIC[@]}"; do
	if ! [ -x "$(command -v ${tool})" ]; then
		TOOLS="git ${TOOLS}"
	fi
done

# Install TOOLS if listed
if ! [[ -e "$TOOLS" ]]; then
	echo 'tools already installed'
else

	if [[ $UID != 0 ]]; then
		echo 'please run as root'
		exit -1
	fi
	echo "installing $TOOLS"
	apt update
	DEBIAN_FRONTEND=noninteractive apt install -y $TOOLS
	echo "tools installed"
fi