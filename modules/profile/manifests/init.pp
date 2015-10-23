class profile::base {

   class { '::ntp':
      servers => ['0.us.pool.ntp.org', '1.us.pool.ntp.org', '2.us.pool.ntp.org', '3.us.pool.ntp.org'],
   }
}

class profile::web-server {

   include ::php
   include ::apache

   apache::vhost { $::fqdn:
      port    => '80',
      docroot =>  '/vagrant',
   }
}

class profile::grunt-foundation {
   
   include custom_node_npm
   
   package { 'git':
      ensure   => 'present',
      provider => 'yum',
      before   => Package['bower'],
   } 

   package { 'bower': 
      ensure   => 'present',
      provider => 'npm', 
      require  => Class['custom_node_npm'],
   }

   package { 'grunt-cli': 
      ensure   => 'present',
      provider => 'npm', 
      require  => Package['bower'],
   }

   package { 'yo': 
      ensure   => 'present',
      provider => 'npm', 
      require  => Package['bower'],
   }
 
   package { 'generator-zf5':
      ensure   => 'present',
      provider => 'npm', 
      require  => Package['yo']
   }
   
   exec { 'npm install':
      path        => ['/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/'],
      command     => 'npm install', 
      cwd         => '/vagrant',
      environment => 'HOME=/home/vagrant',
      require     => [Class['custom_node_npm'], Package['bower', 'grunt-cli', 'yo', 'generator-zf5']], 
      creates     => '/vagrant/node_modules', 
      logoutput   => on_failure,
      timeout     => 1800,   	  
   }
   
   exec { 'bower install':
      path        => ['/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/'],
      command     => 'bower install --config.interactive=false', 
      cwd         => '/vagrant',
      user        => 'vagrant',
      environment => 'HOME=/home/vagrant',
      require     => Exec['npm install'],
      creates     => '/vagrant/app/bower_components', 
      logoutput   => on_failure,
      timeout     => 1800,   	  
   }   
}

