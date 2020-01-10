#!/bin/sh

set -u # check undefined variables
set -e # check errors

# ici je mettrai de quoi installer automatiquement les différents logiciels
# ...
# Je configure mon réseau 
cat > /etc/network/interfaces.d/eth1 <<-MARK
allow-hotplug eth1
iface eth1 inet static
	address 10.0.3.1
	netmask 255.255.255.0
MARK

# J'applique ma configuration réseau
ifup eth1 || true

cat > /etc/network/interfaces.d/eth2 <<-MARK
allow-hotplug eth2
iface eth2 inet static
	address 10.0.4.1
	netmask 255.255.255.0
MARK

# J'applique ma configuration réseau
ifup eth2 || true

# Je prépare mes regles de firewall
sudo echo 1 > /proc/sys/net/ipv4/ip_forward
sudo iptables -t nat -F
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
# Installation des logiciels

sudo apt-get -y install privoxy

echo "SUCCESS"
