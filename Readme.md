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

Notes: running packer to build GUS from iso took much more time than I expected.
       Total OS installation time on my notebook takes about 20 minutes.

### Generic Windows Server (GWS)

Probably I will need this one someday as well.