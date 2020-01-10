#!/bin/sh

set -u # check undefined variables
set -e # check errors

# ici je mettrai de quoi installer automatiquement les différents logiciels
# ...

# Je configure mon réseau 
cat > /etc/network/interfaces.d/eth1 <<-MARK
allow-hotplug eth1
iface eth1 inet static
	address 10.0.4.10
	netmask 255.255.255.0
	gateway 10.0.4.1
	pre-up ip route del default 
MARK

# J'applique ma configuration réseau
ifup eth1 || true

# Installation des logiciels

sudo apt-get -y install w3m

echo "SUCCESS"
