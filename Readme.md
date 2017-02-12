# Hashicorp Microservices Platform

Building microservices infrastrcuture using Hashicorp tools like Consul, Nomda, Vault, Packer, Vagrant.

This is repository that supports my series of blog posts: <https://devraccoon.com/2017/02/01/microservices-journey-with-hashicorp-tools-intro/>

## Tools description

* “Vagrant” – virtual machines manager based on configuration file. Easy to share, easy to version. I’m using it a lot for development environments setup and experimenting, learning purpose.
* “Packer” – virtual machine image creating tool. Can be used to script VM image creation for variety of provider, including AWS, Azure, VirtualBox, VMWare, Vagrant, etc.
* “Nomad” – A distributed, highly available, datacenter-aware scheduler. I believe that in cluster environment resource pool should be manageable by automated software, so application deployment should not be bothered much of deciding what server should an application be deployed at.
* “Consul” – Service discovery tool with built in DNS service, HTTP API endpoints, reactive key/value store and health checks.
* “Vault” – tool for managing secrets. Looks promising. Will put hands on it later.
* “Serf” – gossip member management implementation. Used internally in Consul and Nomad for sharing information between nodes.
* “Terraform” – infrastructure management tool based on configuration files.

## Generic Servers

I need servers to build the cluster. Fr servers I need OS. So, I'm going to use packer and create generic images for the cluster.
There will be two types of servers used: linux and windows. I'll postpone creating windows server as much as possible and will try to
create all based on linux. I'll use Ubuntu 16.04 LTS.

Linux servers will play all infrastrcutural roles as Nomad, Consul servers and will run docker containers.

Windows servers will be created for need of software that can run only on Windows.

### Generic Ubuntu Server (GUS)

I'm going to use ubuntu 16.04.1 as base OS for GUS.
GUS has installed ansible and docker.

Packer tempalte and files that helped me a lot: <https://github.com/geerlingguy/packer-ubuntu-1604>

You can find all provision and template files for packer in "packer" folder.

consul installation on the machine is datacenter aware. It takes datacenter name from hostname by stripping part of the string
before first "-". e.g. "dc1-consul-server-1" will be treated from "dc1" datacenter.

Consul must know advertise address to use, so server can start. The best working sample that I got is to 
change consul start options with systemd environment file.

Notes: running packer to build GUS from iso took much more time than I expected.
       Total OS installation time on my notebook takes about 20 minutes.

### Generic Windows Server (GWS)

Probably I will need this one someday as well.

## Azure setup

Here is the great explanation and step-by-step instruction from packer docs on how to get all required data to run azure-arm builder.
<https://www.packer.io/docs/builders/azure-setup.html>

## todo list

* [X] Switch on using vagrant ssh key instead of password
* [X] Setup consul in image
* [X] Change consul startup from upstart to systemd
* [X] Setup nomad in image
* [ ] Create GUS in Azure
* [ ] Make vagrant boxes versioned
* [ ] Configure consul encryption

## Some links to check

<http://datalinks.nl/wordpress/?page_id=1447>