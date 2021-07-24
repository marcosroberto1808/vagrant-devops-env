# -*- mode: ruby -*-
# vi: set ft=ruby :

# Using Yaml file to load personal settings
require 'yaml'
settings = YAML.load_file 'settings/common.yaml'  # Edit settings/common.yaml values before vagrant up

Vagrant.configure("2") do |config|
    # Base image
    config.vm.box = settings['vm_distro_version']
    # VirtualBox configurations - Change values in settings/common.yaml 
    config.vm.provider "virtualbox" do |v|
      v.name = settings['vm_box_name'] + " ( " + settings['user_name'] + " )"
      v.memory = settings['vm_memory_size']    
      v.cpus = settings['vm_cpu_count']   
    end

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

    # Install docker and docker-compose
    config.vm.provision :docker
    config.vm.provision :docker_compose

    # Sync root folder in the vagrant box
    config.vm.synced_folder ".", "/home/vagrant/documents", :mount_options => ["dmode=777", "fmode=777"]

    # Sync ./projects folder in the vagrant box
    config.vm.synced_folder "./projects", "/home/vagrant/projects", :mount_options => ["dmode=777", "fmode=777"]
    
    # Forward localhost port to the vagrant box 
    config.vm.network "forwarded_port", guest: 80, host: 80
    
    # Forward localhost Jenkins ports to the vagrant box 
    config.vm.network "forwarded_port", guest: 8080, host: 8080
    config.vm.network "forwarded_port", guest: 50000, host: 50000

  end
  