# -*- mode: ruby -*-
# vi: set ft=ruby :

# Using Yaml file to load personal settings
require 'yaml'
settings = YAML.load_file 'settings/common.yaml'  # Edit settings/common.yaml values before vagrant up

Vagrant.configure("2") do |config|
    # Base image
    config.vm.box = settings['vm_distro']
    # VirtualBox configurations - Change values in settings/common.yaml 
    config.vm.provider "virtualbox" do |v|
      v.name = settings['vm_name']        
      v.memory = settings['vm_memory']    
      v.cpus = settings['vm_cpu_count']   
    end

    # Required plugins:
    # https://github.com/tmatilai/vagrant-timezone
    # https://github.com/leighmcculloch/vagrant-docker-compose
    config.vagrant.plugins = ["vagrant-timezone", "vagrant-docker-compose"]
   
    # Setup Timezone
    if Vagrant.has_plugin?("vagrant-timezone")
      config.timezone.value = settings['timezone'] 
    end

    # Install docker and docker-compose
    config.vm.provision :docker
    config.vm.provision :docker_compose

    # Sync the root folder in the vagrant box
    config.vm.synced_folder ".", "/home/vagrant/documents", :mount_options => ["dmode=777", "fmode=777"]

    # Sync the projects folder in the vagrant box
    config.vm.synced_folder "./projects", "/home/vagrant/projects", :mount_options => ["dmode=777", "fmode=777"]
    
    # Forward localhost port to the vagrant box 
    config.vm.network "forwarded_port", guest: 80, host: 80

  end
  