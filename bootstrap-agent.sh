if which puppet > /dev/null 2>&1; then
  echo 'Puppet Installed.'
else
  echo 'Installing Development Environment!'
  rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
  yum --nogpgcheck -y install puppet
  
  echo 'Puppet installed! Now configuring dev environment...'

  # Set Master server hostname and environment to development
  puppet config set --section main server puppetmaster.development.vbox
  puppet config set --section agent environment development

  # Allow Foreman to trigger Puppet runs using Puppet kick (deprecated in Puppet 4.0)
  puppet config set --section agent listen true
  sudo touch /etc/puppet/namespaceauth.conf # Can remain empty, needed for bug
  sudo sed -i '/# deny everything else/i path /run\nauth any\nmethod save\nallow puppetmaster.development.vbox\n' /etc/puppet/auth.conf
  
  # Disable firewall for now
  /usr/bin/puppet resource service iptables ensure=stopped enable=false
  
  # Set hostnames and IPs
  echo '192.168.50.2  puppetmaster.development.vbox  puppetmaster' | sudo tee --append /etc/hosts 2> /dev/null && \
  echo '192.168.50.3  tommys-mbp.development.vbox    tommys-mbp'   | sudo tee --append /etc/hosts 2> /dev/null && \
  echo '192.168.50.3  tommys-mbp-2.development.vbox  tommys-mbp-2' | sudo tee --append /etc/hosts 2> /dev/null && \
  echo '192.168.50.3  dhcp-82-204.development.vbox   dhcp-82-204'  | sudo tee --append /etc/hosts 2> /dev/null && \
  echo '192.168.50.4  production.vbox   			 production'   | sudo tee --append /etc/hosts 2> /dev/null && \
  
  # Change directories to Grunt project folder for Vagrant user on shell start
  # echo "cd /vagrant/www/" >> /home/vagrant/.bash_profile
      
  # Start Puppet and request cert
  sudo puppet resource service puppet ensure=running enable=true  
fi