#!/bin/bash
set -euo pipefail

# accepts GO_VERSION for a specific version of golang
# TODO: if go is already installed, this script will not install a different version
# accepts MONO_USER to configure a gopath and modify their .bashrc
# accepts GO_PACKAGES for a space separated list of packages to go get for the user

# installs go to /go

GO_VERSION="${GO_VERSION:-1.9.2}"

bash ./tools.bash

if [[ $UID != 0 ]]; then
	echo 'please run as root'
	exit -1
fi

if [[ -e "$MONO_USER" ]]; then
	echo 'please specify a user to install go for with MONO_USER'
	exit -1
fi

if [ -x "$(command -v go)" ]; then
	echo 'go already installed'
	exit
else
	echo 'installing go to /opt/go'
	TARFILE=go${GO_VERSION}.linux-amd64.tar.gz
	cd /tmp/
	wget https://storage.googleapis.com/golang/$TARFILE -q
	cd /opt
	tar -xf /tmp/$TARFILE
	rm /tmp/$TARFILE
fi

if [ ! -f /home/$MONO_USER/.profile ]; then
	touch /home/$MONO_USER/.profile
fi

if grep -Fxq "GOPATH" /home/$MONO_USER/.profile; then
	echo 'GOPATH already configured for $MONO_USER'
else
	echo "configuring GOPATH for $MONO_USER"
	echo 'export PATH="/opt/go/bin:$PATH"' >> /home/$MONO_USER/.profile
	echo "export GOPATH=/home/${MONO_USER}/go" >> /home/$MONO_USER/.profile
	echo "export GOROOT=/opt/go" >> /home/$MONO_USER/.profile
fi
arr=($GO_PACKAGES)
for tool in $arr; do
	su $MONO_USER -l -c "go get $tool"
done