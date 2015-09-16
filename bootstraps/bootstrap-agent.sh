if which puppet > /dev/null 2>&1; then
  echo 'Puppet Installed.'
else
  echo 'Installing Development Environment!'
  rpm -ivh http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-11.noarch.rpm
  yum --nogpgcheck -y install puppet
  
  echo 'Puppet installed! Now configuring dev environment...'

  # Set Master server hostname and environment to development
  puppet config set --section main server puppetmaster.development.vbox
  puppet config set --section agent environment development

  # Disable firewall for now
  /usr/bin/puppet resource service iptables ensure=stopped enable=false
  
  # Set hostnames and IPs
  echo '192.168.50.2  puppetmaster.development.vbox  puppetmaster' | sudo tee --append /etc/hosts 2> /dev/null && \
  echo '192.168.50.3  tommys-mbp.development.vbox    tommys-mbp'   | sudo tee --append /etc/hosts 2> /dev/null && \
  
  # Change directories to Grunt project folder for Vagrant user on shell start
  echo "cd /vagrant/www/app" >> /home/vagrant/.bash_profile
      
  # Request cert
  sudo puppet resource service puppet ensure=running enable=true
  
  if [ -d /vagrant/www/node_modules ] && which npm > /dev/null 2>&1; then

	  # Build node-sass binaries for Linux if project exists
	  # Multiple OS binaries can co-exist - In my case, I need one for OS X (my local dev machine) and one for CentOS (VM)  
	  cd /vagrant/www/node_modules/node-sass/vendor
	  npm install
	  
	  # Start Grunt task on server
	  cd /vagrant/www/app
	  grunt
  fi  
fi