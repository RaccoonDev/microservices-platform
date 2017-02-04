#!/usr/bin/env bash

# copy config file for consul
sudo cp /vagrant/provision/cs-consul.d/* /etc/consul.d

# start the service
sudo service consul start
