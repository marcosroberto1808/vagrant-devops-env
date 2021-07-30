# DevOps Local Environment Example using Vagrant
## How to use

### Project samples for use in the Jenkins pipeline

#### Simple HTML website example
https://github.com/marcosroberto1808/mywebsite-docker.git

#### Grafana monitoring tool
https://github.com/marcosroberto1808/grafana-docker.git

### Requirements
* VirtualBox - https://www.virtualbox.org/wiki/Downloads
* Vagrant - https://www.vagrantup.com/downloads
* GitHub Account - https://github.com
* SocketXP Account - https://www.socketxp.com

Custom Installed vagrant plugins and scripts:
 - [x] vagrant-timezone - Fix timezone in all boxes
 - [x] vagrant-docker-compose - Install docker and docker-compose in all boxes
 - [x] enable_ssh.sh script - Fix external ssh access to all boxes
 - [x] install_jenkins.sh script - Install jenkins

### Before starting
* Create account on the https://www.socketxp.com and copy the Auth Token
* Duplicate or rename settings/common.yaml.example => settings/common.yaml
* Locate and edit the variables in settings/common.yaml with your personal settings
```
# Locale settings
user_name: "Your_Name"   # <= Put your name
local_timezone: "America/Fortaleza"

# github settings
git_email: "your_email"  # <= Change to your github email account

# socketxp settings
socketxp_token: "SOCKETXP_TOKEN"  # <= Change to your SocketXP Auth Token
```
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
