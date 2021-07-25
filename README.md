# DevOps Local Environment Example using Vagrant
## How to use

### Requirements
* VirtualBox - https://www.virtualbox.org/wiki/Downloads
* Vagrant - https://www.vagrantup.com/downloads

Pre-Installed vagrant plugins:
 - [x] vagrant-timezone - Fix timezone in all boxes
 - [x] vagrant-docker-compose - Install docker and docker-compose in all boxes
 - [x] enable_ssh.sh script - Fix external ssh access in all boxes

### Before starting

Edit the settings/common.yaml file with your personal configuration.

### How to start

To start all 3 vagrant boxes (devops, jenkins, dev) at once:

`vagrant up`

To start specific box:

`vagrant up devops`

To access specific box:

`vagrant ssh devops`

To destroy all vagrant boxes:

`vagrant destroy`

To destroy specific box:

`vagrant destroy devops`

To stop all vagrant boxes:

`vagrant halt`
