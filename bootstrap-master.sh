if which puppet > /dev/null 2>&1; then
  echo 'Puppet Installed.'
else
  echo 'Installing Puppet Master...'
  rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
  yum -y install epel-release http://yum.theforeman.org/releases/1.9/el6/x86_64/foreman-release.rpm
  yum -y install foreman-installer
  foreman-installer
  
  sudo /usr/bin/puppet resource service iptables ensure=stopped enable=false
  
  # Install shared modules from Puppet Forge
    sudo puppet module install -i /etc/puppet/modules puppetlabs-ntp
    sudo puppet module install -i /etc/puppet/modules treydock-gpg_key    
    sudo puppet module install -i /etc/puppet/modules puppetlabs-apache
    sudo puppet module install -i /etc/puppet/modules mayflower-php
  
    sudo chmod 444 /etc/puppet/modules/yum/metadata.json
   
fi