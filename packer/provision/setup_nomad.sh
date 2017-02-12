#!/bin/bash -eux

# Download nomad
NOMAD_VERSION=0.5.4
curl -sSL https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip -o nomad.zip

# Install nomad
unzip nomad.zip
sudo chmod +x nomad
sudo mv nomad /usr/bin/nomad

# Create nomad user
sudo useradd -r -s /bin/false nomad

# Create config directory
sudo mkdir -p /etc/nomad.d
sudo cp /tmp/upload/nomad.d/client.hcl /etc/nomad.d/
sudo cp /tmp/upload/nomad.d/server.hcl /etc/nomad.d/

# Create nomad data directory
# sudo mkdir -p /var/nomad
# sudo chown nomad:nomad /var/nomad

# Configure systemd
sudo cp /tmp/upload/systemd/nomad.service /etc/systemd/system/
sudo cp /tmp/upload/systemd/nomad.environment /etc/sysconfig/nomad

sudo systemctl enable nomad
sudo systemctl start nomad
