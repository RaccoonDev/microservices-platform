#!/bin/bash -eux

apt-get install -y upstart curl unzip bc stress

# Disable daily apt unattended updates.
echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic

# Setup coloring in console
cat >> /home/vagrant/.bashrc <<"END"

# Coloring of hostname in prompt to keep track of what's what in demos, blue provides a little emphasis but not too much like red
NORMAL="\[\e[0m\]"
BOLD="\[\e[1m\]"
DARKGRAY="\[\e[90m\]"
BLUE="\[\e[34m\]"
PS1="$DARKGRAY\u@$BOLD$BLUE\h$DARKGRAY:\w\$ $NORMAL"

END

# Download consul
CONSUL_VERSION=0.7.3
curl https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -o consul.zip

# Install consul
unzip consul.zip
sudo chmod +x consul
sudo mv consul /usr/bin/consul

# Create config directory
sudo mkdir /etc/consul.d
sudo chmod a+w /etc/consul.d
sudo mkdir /etc/consul.d/server
sudo chmod a+w /etc/consul.d/server
sudo mkdir /etc/consul.d/client
sudo chmod a+w /etc/consul.d/client

# Install common consul config
sudo cp /tmp/upload/common-consul.d/* /etc/consul.d

# Install consul server configuration
sudo cp /tmp/upload/server-consul.d/* /etc/consul.d/server

# Install consul client configuration
sudo cp /tmp/upload/client-consul.d/* /etc/consul.d/client

# Install upstart job
sudo cp /tmp/upload/upstart/consul.conf /etc/init/.
