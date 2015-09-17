if which puppet > /dev/null 2>&1; then
  echo 'Puppet Installed.'
else
  echo 'Installing Puppet Master...'
  rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
  yum -y install epel-release http://yum.theforeman.org/releases/1.9/el6/x86_64/foreman-release.rpm
  yum -y install foreman-installer
  foreman-installer
  
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
   
fi