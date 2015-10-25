class role::web-dev {
   include profile::base
   include profile::grunt-foundation
}

class role::web-server-production {
   include profile::base
   include profile::web-server	
}