# -*- mode: ruby -*-
# vi: set ft=ruby :

# Using Yaml file to load personal settings
require 'yaml'
settings = YAML.load_file 'settings/common.yaml'  # Edit settings/common.yaml values before vagrant up
timestamp = Time.now.strftime("%d%m%Y_%H%M")

Vagrant.configure("2") do |config|

    # DevOps box configuration
    config.vm.define "devops" do |devops|
      # Base image
      devops.vm.box = settings['devops_vm_distro_version']
      devops.vm.hostname  = settings['devops_vm_box_name'] + ".local"
      # VirtualBox configurations - Change values in settings/common.yaml 
      devops.vm.provider "virtualbox" do |v|
        v.name = settings['devops_vm_box_name'] + " ( " + settings['user_name'] + " )" + " #{timestamp}"
        v.memory = settings['devops_vm_memory_size']    
        v.cpus = settings['devops_vm_cpu_count']   
      end

      # Forward jenkins port to the vagrant box 
      devops.vm.network "private_network", ip: settings['devops_ip'], hostname: true
      devops.vm.network "forwarded_port", guest: 80, host: 80

    end

    # Jenkins box configuration
    config.vm.define "jenkins" do |jenkins|
      # Base image
      jenkins.vm.box = settings['jenkins_vm_distro_version']
      jenkins.vm.hostname  = settings['jenkins_vm_box_name'] + ".local"
      # VirtualBox configurations - Change values in settings/common.yaml 
      jenkins.vm.provider "virtualbox" do |v|
        v.name = settings['jenkins_vm_box_name'] + " ( " + settings['user_name'] + " )"+ " #{timestamp}"
        v.memory = settings['jenkins_vm_memory_size']    
        v.cpus = settings['jenkins_vm_cpu_count']   
      end

      # Forward jenkins port to the vagrant box
      jenkins.vm.network "private_network", ip: settings['jenkins_ip'], hostname: true
      jenkins.vm.network "forwarded_port", guest: 8080, host: 8080
      jenkins.vm.network "forwarded_port", guest: 50000, host: 50000

      # Install java
      jenkins.vm.provision "shell", inline: "sudo apt install default-jre -y", privileged: false
      jenkins.vm.provision "shell", inline: "sudo apt install default-jdk -y", privileged: false
      
      # Install Jenkins
      jenkins.vm.provision "shell", path: "./scripts/install_jenkins.sh", run: "once"
      
      # Install Ansible
      jenkins.vm.provision "shell", inline: "sudo apt install ansible sshpass -y", privileged: false
      jenkins.vm.provision "file", source: "settings/ansible_hosts", destination: "/home/vagrant/"
      jenkins.vm.provision "shell",  inline: "sudo mv /home/vagrant/ansible_hosts /etc/ansible/hosts", privileged: false 

      # Install SocketXP
      jenkins.vm.provision "shell",  inline: "sudo curl -O https://portal.socketxp.com/download/linux/socketxp", privileged: false 
      jenkins.vm.provision "shell",  inline: "sudo chmod +wx socketxp ", privileged: false 
      jenkins.vm.provision "shell",  inline: "sudo mv socketxp /usr/local/bin", privileged: false 
      jenkins.vm.provision "file", source: "settings/socketxp.json", destination: "/home/vagrant/" 
      jenkins.vm.provision "shell",  inline: "socketxp login #{settings['socketxp_token']}", privileged: false 
      jenkins.vm.provision "shell",  inline: "sed -i -e 's/SOCKETXP_TOKEN/#{settings['socketxp_token']}/' /home/vagrant/socketxp.json", privileged: false 
      jenkins.vm.provision "shell",  inline: "sudo socketxp service install --config /home/vagrant/socketxp.json", privileged: false 
      jenkins.vm.provision "shell",  inline: "sudo systemctl enable socketxp && sudo systemctl start socketxp", privileged: false
      jenkins.vm.provision "shell",  inline: "sleep 10 && echo " " && socketxp tunnel ls | grep -B 2 -A 2 URL", privileged: false, run: "always"

    end

    # Dev box configuration
    config.vm.define "dev" do |dev|
      # Base image
      dev.vm.box = settings['dev_vm_distro_version']
      dev.vm.hostname  = settings['dev_vm_box_name'] + ".local"
      # VirtualBox configurations - Change values in settings/common.yaml 
      dev.vm.provider "virtualbox" do |v|
        v.name = settings['dev_vm_box_name'] + " ( " + settings['user_name'] + " )"+ " #{timestamp}"
        v.memory = settings['dev_vm_memory_size']    
        v.cpus = settings['dev_vm_cpu_count']   
      end
      # Forward dev port to the vagrant box
      dev.vm.network "private_network", ip: settings['dev_ip'], hostname: true
      dev.vm.network "forwarded_port", guest: 80, host: 8081

    end

    ## Global boxes config
    # Install Required plugins:
    VAGRANT_PLUGINS = %w[vagrant-timezone vagrant-docker-compose]
    VAGRANT_PLUGINS.each do |plugin|
      unless Vagrant.has_plugin?("#{plugin}")
        system("vagrant plugin install #{plugin}")
        exit system('vagrant', *ARGV)
      end
    end
  
    # Setup Timezone
    if Vagrant.has_plugin?("vagrant-timezone")
      config.timezone.value = settings['local_timezone'] 
    end

    # Enable external SSH With Password
    config.vm.provision "shell", path: "./scripts/enable_ssh.sh", run: "once"

    # Setup the git config --global vars
    config.vm.provision "shell", inline: "git config --global user.name #{settings['git_email']}", run: "once", privileged: false
    config.vm.provision "shell", inline: "git config --global user.email #{settings['git_email']}", run: "once", privileged: false
    config.vm.provision "shell", inline: "git config --list", run: "once", privileged: false

    # Install docker and docker-compose
    config.vm.provision :docker
    config.vm.provision :docker_compose

    # Sync root folder in the vagrant box
    config.vm.synced_folder ".", "/home/vagrant/documents", :mount_options => ["dmode=777", "fmode=777"]

    # Sync ./projects folder in the vagrant box
    config.vm.synced_folder "./projects", "/home/vagrant/projects", :mount_options => ["dmode=777", "fmode=777"]
    
  end
  