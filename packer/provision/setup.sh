#!/bin/bash -eux

sudo apt-get install -y upstart curl unzip bc stress vim jq

# Disable daily apt unattended updates.
#echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic

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
CONSUL_VERSION=0.7.4
curl -s https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -o consul.zip

# Install consul
unzip consul.zip
sudo chmod +x consul
sudo mv consul /usr/bin/consul

# Create consul user
sudo useradd -r -s /bin/false consul

# Create config directory
sudo mkdir -p /etc/consul.d/{bootstrap,server,client}
sudo cp /tmp/upload/consul.d/server/* /etc/consul.d/server
sudo cp /tmp/upload/consul.d/client/* /etc/consul.d/client
sudo cp /tmp/upload/consul.d/bootstrap/* /etc/consul.d/client/bootstrap

# Create consul data directory
sudo mkdir -p /var/consul
sudo chown consul:consul /var/consul

# Configure systemd
sudo mkdir /etc/sysconfig
sudo cp /tmp/upload/systemd/consul.service /etc/systemd/system/
sudo cp /tmp/upload/systemd/consul.environment /etc/sysconfig/consul

sudo systemctl enable consul
sudo systemctl start consul
