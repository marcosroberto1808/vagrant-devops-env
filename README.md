# DevOps Local Environment using Vagrant
## How to use

### Requirements
* VirtualBox - https://www.virtualbox.org/wiki/Downloads
* Vagrant - https://www.vagrantup.com/downloads

Pre Install vagrant plugins:
 - [x] vagrant-timezone - To fix timezone inside the vagrant box
 - [x] vagrant-docker-compose - To install docker and docker-compose inside the vagrant box

### Before starting

Before using vagrant up, install the required plugins:

`vagrant plugin install vagrant-timezone`

`vagrant plugin install vagrant-docker-compose`

Edit the settings/common.yaml file with your custom configuration.

### How to start

To start the vagrant box:

`vagrant up`

To access the vagrant box:

`vagrant ssh`

To destroy the vagrant box:

`vagrant destroy`

To stop the vagrant box:

`vagrant halt`
