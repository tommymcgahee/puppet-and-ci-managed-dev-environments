class profile::grunt-foundation {

   # Install node.js and packages   

   class { 'nodejs': }

   package { 'bower': 
      ensure   => 'present',
      provider => 'npm', 
      require  => Package['nodejs'],
   }

   package { 'grunt-cli': 
      ensure   => 'present',
      provider => 'npm', 
      require  => Package['nodejs'],
   }

   package { 'yo': 
      ensure   => 'present',
      provider => 'npm', 
      require  => Package['nodejs'],
   }
 
   package { 'generator-zf5':
      ensure   => 'present',
      provider => 'npm', 
      require  => [ Package['nodejs'], Package['yo'] ]
   }

   # Configure apache

   include apache 
   apache::vhost { $::fqdn:
      port    => '80',
      docroot =>  '/vagrant/www',
   }
}

