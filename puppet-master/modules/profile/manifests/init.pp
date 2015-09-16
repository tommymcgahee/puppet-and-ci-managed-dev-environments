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

   package { 'git':
      ensure   => 'present',
      provider => 'yum',
      before   => Package['bower'],
   } 
   
   include custom_node_npm

   package { 'bower': 
      ensure   => 'present',
      provider => 'npm', 
      require  => Class['custom_node_npm'],
   }

   package { 'grunt-cli': 
      ensure   => 'present',
      provider => 'npm', 
      require  => Class['custom_node_npm'],
   }

   package { 'yo': 
      ensure   => 'present',
      provider => 'npm', 
      require  => Class['custom_node_npm'],
   }
 
   package { 'generator-zf5':
      ensure   => 'present',
      provider => 'npm', 
      require  => Package['yo']
   }
}

