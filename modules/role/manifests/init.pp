class role::iws-dev {
   include profile::base
   include profile::web-server
   include profile::grunt-foundation
}

class role::web-server-production {
   include profile::base
   include profile::web-server	
}