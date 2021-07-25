# -*- mode: ruby -*-
# vi: set ft=ruby :

# Using Yaml file to load personal settings
require 'yaml'
settings = YAML.load_file 'settings/common.yaml'  # Edit settings/common.yaml values before vagrant up

Vagrant.configure("2") do |config|

    # DevOps box configuration
    config.vm.define "devops" do |devops|
      # Base image
      devops.vm.box = settings['devops_vm_distro_version']
      devops.vm.hostname  = settings['devops_vm_box_name'] + ".local"
      # VirtualBox configurations - Change values in settings/common.yaml 
      devops.vm.provider "virtualbox" do |v|
        v.name = settings['devops_vm_box_name'] + " ( " + settings['user_name'] + " )"
        v.memory = settings['devops_vm_memory_size']    
        v.cpus = settings['devops_vm_cpu_count']   
      end
      # Forward jenkins port to the vagrant box 
      devops.vm.network "private_network", ip: "192.168.50.11", hostname: true
      devops.vm.network "forwarded_port", guest: 80, host: 80

    end

    # Jenkins box configuration
    config.vm.define "jenkins" do |jenkins|
      # Base image
      jenkins.vm.box = settings['jenkins_vm_distro_version']
      jenkins.vm.hostname  = settings['jenkins_vm_box_name'] + ".local"
      # VirtualBox configurations - Change values in settings/common.yaml 
      jenkins.vm.provider "virtualbox" do |v|
        v.name = settings['jenkins_vm_box_name'] + " ( " + settings['user_name'] + " )"
        v.memory = settings['jenkins_vm_memory_size']    
        v.cpus = settings['jenkins_vm_cpu_count']   
      end
      # Forward jenkins port to the vagrant box
      jenkins.vm.network "private_network", ip: "192.168.50.12", hostname: true
      jenkins.vm.network "forwarded_port", guest: 8080, host: 8080
      jenkins.vm.network "forwarded_port", guest: 50000, host: 50000

    end

    # Dev box configuration
    config.vm.define "dev" do |dev|
      # Base image
      dev.vm.box = settings['dev_vm_distro_version']
      dev.vm.hostname  = settings['dev_vm_box_name'] + ".local"
      # VirtualBox configurations - Change values in settings/common.yaml 
      dev.vm.provider "virtualbox" do |v|
        v.name = settings['dev_vm_box_name'] + " ( " + settings['user_name'] + " )"
        v.memory = settings['dev_vm_memory_size']    
        v.cpus = settings['dev_vm_cpu_count']   
      end
      # Forward dev port to the vagrant box
      dev.vm.network "private_network", ip: "192.168.50.13", hostname: true
      dev.vm.network "forwarded_port", guest: 80, host: 8081

    end

    ## Global boxes config
    # Install Required plugins:
    VAGRANT_PLUGINS = [
      "vagrant-timezone",
      "vagrant-docker-compose"
      ]
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

    # Install docker and docker-compose
    config.vm.provision :docker
    config.vm.provision :docker_compose

    # Sync root folder in the vagrant box
    config.vm.synced_folder ".", "/home/vagrant/documents", :mount_options => ["dmode=777", "fmode=777"]

    # Sync ./projects folder in the vagrant box
    config.vm.synced_folder "./projects", "/home/vagrant/projects", :mount_options => ["dmode=777", "fmode=777"]
    
  end
  