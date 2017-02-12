#!/bin/bash -eux

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
sudo cp /tmp/upload/consul.d/bootstrap/* /etc/consul.d/bootstrap

# Create consul data directory
sudo mkdir -p /var/consul
sudo chown consul:consul /var/consul

# Configure systemd
sudo cp /tmp/upload/systemd/consul.service /etc/systemd/system/
sudo cp /tmp/upload/systemd/consul.environment /etc/sysconfig/consul

sudo systemctl enable consul
sudo systemctl start consul
