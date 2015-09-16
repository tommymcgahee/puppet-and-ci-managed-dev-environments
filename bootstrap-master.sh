if which puppet > /dev/null 2>&1; then
  echo 'Puppet Installed.'
else
  echo 'Installing Puppet Master...'
  rpm -ivh http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-11.noarch.rpm
  yum --nogpgcheck -y install puppet-server
  
  # Configure puppet.conf and cert autosign
  #puppet config set --section main modulepath  /etc/puppet/modules
  puppet config set --section main environmentpath  \$confdir/environments
  puppet config set --section master autosign  true
  echo '*.development.vbox' > /etc/puppet/autosign.conf
  
  # Set hostnames and IPs
  echo '192.168.50.2  puppetmaster.development.vbox  puppetmaster' | sudo tee --append /etc/hosts 2> /dev/null && \
  echo '192.168.50.3  tommys-mbp.development.vbox    tommys-mbp'   | sudo tee --append /etc/hosts 2> /dev/null && \
  
  # Make dev env & transfer site.pp; transfer custom global role, profile and modified nodejs modules (all included in project repo)
  mkdir -p /etc/puppet/environments/development/{manifests,modules}
  cp /vagrant/development/manifests/site.pp /etc/puppet/environments/development/manifests
  cp -r /vagrant/modules/{role,profile,custom_node_npm} /etc/puppet/modules
    
  # Install shared modules from Puppet Forge
  sudo puppet module install -i /etc/puppet/modules puppetlabs-ntp
  sudo puppet module install -i /etc/puppet/modules treydock-gpg_key    
  sudo puppet module install -i /etc/puppet/modules puppetlabs-apache
  sudo puppet module install -i /etc/puppet/modules mayflower-php
  
  sudo chmod 444 /etc/puppet/modules/yum/metadata.json
  
  /usr/bin/puppet resource service iptables ensure=stopped enable=false
  /usr/bin/puppet resource service puppetmaster ensure=running enable=true  
  
fi