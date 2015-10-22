#!/usr/bin/env bash

if which puppet > /dev/null 2>&1; then
  echo 'Puppet Installed.'
else
  echo 'Installing Puppet Master...'
  rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
  yum -y install epel-release http://yum.theforeman.org/releases/1.9/el6/x86_64/foreman-release.rpm
  yum -y install foreman-installer
  foreman-installer
  
  # Set hostnames and IPs
  echo '192.168.50.2  puppetmaster.development.vbox  puppetmaster' | sudo tee --append /etc/hosts 2> /dev/null && \
  echo '192.168.50.3  tommys-mbp.development.vbox    tommys-mbp'   | sudo tee --append /etc/hosts 2> /dev/null && \
  echo '192.168.50.3  tommys-mbp-2.development.vbox  tommys-mbp-2' | sudo tee --append /etc/hosts 2> /dev/null && \
  echo '192.168.50.3  dhcp-82-204.development.vbox   dhcp-82-204'  | sudo tee --append /etc/hosts 2> /dev/null && \
  echo '192.168.50.4  production.vbox   			 production'   | sudo tee --append /etc/hosts 2> /dev/null && \
  
  sudo /usr/bin/puppet resource service iptables ensure=stopped enable=false
  
  sudo cp /vagrant/development/manifests/site.pp /etc/puppet/environments/development/manifests
  sudo cp -r /vagrant/modules/{role,profile,custom_node_npm} /etc/puppet/modules
  sudo mkdir /etc/puppet/environments/common/{manifests,modules}
  
  # Install shared modules from Puppet Forge
  sudo puppet module install -i /etc/puppet/modules puppetlabs-ntp
  sudo puppet module install -i /etc/puppet/modules treydock-gpg_key    
  sudo puppet module install -i /etc/puppet/modules puppetlabs-apache
  sudo puppet module install -i /etc/puppet/modules mayflower-php
  
  sudo chmod -R 775 /etc/puppet/modules/yum
  
  echo $'\nDefaults:foreman-proxy !requiretty\nforeman-proxy ALL = NOPASSWD: /usr/bin/puppet kick *' | sudo tee -a /etc/sudoers
fi