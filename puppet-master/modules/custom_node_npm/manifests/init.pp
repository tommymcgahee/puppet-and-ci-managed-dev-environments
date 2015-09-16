class custom_node_npm {
   ## CentOS 6 nodesource repo includes <= node.js 0.10.x and we need 0.12.x

   yumrepo { 'nodejs-0.12':
      descr           => 'Node.js is a platform built on Chrome\'s JavaScript runtime for easily building fast, scalable network applications.',
      baseurl         => 'https://rpm.nodesource.com/pub_0.12/el/6/x86_64',
      enabled         => '1',
      failovermethod  => 'priority',
      gpgcheck        => '0',
   }

   package { 'nodejs':
      ensure   =>  'present',
      provider =>  'yum',
      require  =>  Yumrepo['nodejs-0.12'],
   }
}
