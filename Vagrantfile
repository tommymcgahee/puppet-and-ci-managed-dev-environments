# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.5.0"
#require 'vagrant-hosts'
#require 'vagrant-auto_network'
require 'vagrant-hostmanager'

Vagrant.configure('2') do |config|
  
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  config.vm.define 'development' do |node|
    
    node.vm.box = 'puppetlabs/centos-6.6-64-nocm'    
    
    os_hostname = "#{`hostname`[0..-2]}".sub(/\..*$/,'')+".development.vbox"
    os_hostname.downcase!
    
    node.vm.hostname = os_hostname

    # Use vagrant-auto_network to assign an IP address.
    #node.vm.network :private_network, :auto_network => true
    node.vm.network "public_network"

    # Use vagrant-hosts to add entries to /etc/hosts for each virtual machine in this file.
    #node.vm.provision :hosts

    node.vm.provision 'shell', path: 'bootstraps/bootstrap-agent.sh'
  end
end