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
      docroot =>  '/vagrant/www/app',
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
      path    => '/usr/bin/npm',
      command => 'npm install', 
      cwd     => '/vagrant/www',
      require => [Class['custom_node_npm'], Package['bower', 'grunt-cli', 'yo', 'generator-zf5']], 
      creates => '/vagrant/www/node_modules', 
      timeout => 1800,   	  
   }
   
   exec { 'bower install':
      path    => '/usr/bin/bower',
      command => 'bower install', 
      cwd     => '/vagrant/www/app',
      require => Exec['npm install'],
      creates => '/vagrant/www/app/bower_components', 
      timeout => 1800,   	  
   }   
}

