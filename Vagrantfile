# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.5.0"
#test push
#require 'vagrant-hosts'
#require 'vagrant-auto_network'
#require 'vagrant-hostmanager'

Vagrant.configure('2') do |config|
  
  #config.hostmanager.enabled = true
  #config.hostmanager.manage_host = true
  #config.hostmanager.ignore_private_ip = false
  #config.hostmanager.include_offline = true
    
  config.vm.define 'puppetmaster' do |node|
    
    node.vm.box = 'puppetlabs/centos-6.6-64-nocm'
    node.vm.hostname = 'puppetmaster.development.vbox'

    # Use vagrant-auto_network to assign an IP address.
    node.vm.network 'private_network', ip: '192.168.50.2'
    #node.vm.network :private_network, :auto_network => true
    #node.vm.network "public_network"    

    # Use vagrant-hosts to add entries to /etc/hosts for each virtual machine in this file.
    #node.vm.provision :hosts
    
    node.vm.provision 'shell', path: 'bootstrap-master.sh'
  end
end
