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

   package { 'git':
      ensure   => 'present',
      provider => 'yum',
      before   => Package['nodejs-0.12.7-1nodesource.el6.x86_64'],
   } 

   package { 'nodejs-0.12.7-1nodesource.el6.x86_64': 
      ensure   =>  'present',
      provider =>  'rpm',
      source   =>  'https://rpm.nodesource.com/pub_0.12/el/6/x86_64/nodejs-0.12.7-1nodesource.el6.x86_64.rpm',
   }

   include customnpm

   package { 'bower': 
      ensure   => 'present',
      provider => 'npm', 
      require  => Class['customnpm'],
   }

   package { 'grunt-cli': 
      ensure   => 'present',
      provider => 'npm', 
      require  => Class['customnpm'],
   }

   package { 'yo': 
      ensure   => 'present',
      provider => 'npm', 
      require  => Class['customnpm'],
   }
 
   package { 'generator-zf5':
      ensure   => 'present',
      provider => 'npm', 
      require  => [ Class['customnpm'], Package['yo'] ]
   }
}

