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

### Configure Jenkins
* Access jenkins box terminal with the command:
`vagrant ssh jenkins`
* Get the initialAdminPassword using this command:
`cat /var/lib/jenkins/secrets/initialAdminPassword`
* Access the jenkins login page and configure admin user and log in in the jenkins  
`http://localhost:8080`
* Install Ansible plugin 
`Manage Jenkins > Manage Plugins > Available > Search for Ansible`
* Configure Ansible plugin
`Manage Jenkins > Global Tool Configuration > Ansible > Add Ansible > Insert Name ansible and Path /usr/bin > Save`
* Generate jenkins admin token to use in github webhook
`Manage Jenkins > Manage Users > Ansible > Choose admin > Configure > Add new Token and copy it > Save`
### Configure GitHub webhooks
* Access jenkins box terminal with the command:
`vagrant ssh jenkins`
* Get the SocketXP Public URL using this command:
`socketxp tunnel ls`
* Access the GitHub project, in the settings page, and configure the WebHook for each project with:
`Payload  URL: https://SocketXP_Public_URL.socketxp.com/github-webhook/`
`Secret: the jenkins Token from admin user`
  
### Configure the Pipeline in Jenkins using the sample projects
* mywebsite-docker:
`Dashboard > New Item > name: mywebsite-docker > Choose Pipeline and hit OK`
`Check GitHub project and put the git project url: https://github.com/marcosroberto1808/mywebsite-docker.git`
`Check GitHub hook trigger for GITScm polling and choose Pipeline script from SCM and change SCM to git`
`add the repository URL with https://github.com/marcosroberto1808/mywebsite-docker.git and hit Save`
* grafana-docker:
`Dashboard > New Item > name: grafana-docker > Choose Pipeline and hit OK`
`Check GitHub project and put the git project url: https://github.com/marcosroberto1808/grafana-docker.git`
`Check GitHub hook trigger for GITScm polling and choose Pipeline script from SCM and change SCM to git`
`add the repository URL with https://github.com/marcosroberto1808/grafana-docker.git and hit Save`
