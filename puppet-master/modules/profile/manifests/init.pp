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
      docroot =>  '/vagrant/www/dist',
   }
}

class profile::grunt-foundation {

   ## CentOS 6 includes node.js 0.10.x and we need 0.12.x   

   class { 'nodejs':
      before   => Package['nodejs-0.12.7-1nodesource.el6.x86_64'],
   }

   package { 'nodejs-0.12.7-1nodesource.el6.x86_64': 
      provider =>  'rpm', 
      ensure   =>  'present',
      source   =>  'https://rpm.nodesource.com/pub_0.12/el/6/x86_64/nodejs-0.12.7-1nodesource.el6.x86_64.rpm',
      require  =>  Package['nodejs'],
   }

   package { 'bower': 
      ensure   => 'present',
      provider => 'npm', 
      require  => Package['nodejs-0.12.7-1nodesource.el6.x86_64'],
   }

   package { 'grunt-cli': 
      ensure   => 'present',
      provider => 'npm', 
      require  => Package['nodejs-0.12.7-1nodesource.el6.x86_64'],
   }

   package { 'yo': 
      ensure   => 'present',
      provider => 'npm', 
      require  => Package['nodejs-0.12.7-1nodesource.el6.x86_64'],
   }
 
   package { 'generator-zf5':
      ensure   => 'present',
      provider => 'npm', 
      require  => [ Package['nodejs-0.12.7-1nodesource.el6.x86_64'], Package['yo'] ]
   }
}

