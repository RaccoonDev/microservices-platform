#!/bin/bash -e

sudo apt-get install -y curl \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual

sudo apt-get install -y apt-transport-https \
                       ca-certificates

curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -                       

sudo add-apt-repository \
       "deb https://apt.dockerproject.org/repo/ \
       ubuntu-$(lsb_release -cs) \
       main"

sudo apt-get update

# use the following to get specific docker version
# sudo apt-get -y install docker-engine=<VERSION_STRING>
sudo apt-get -y install docker-engine
