## Create a Puppet-provisioned development VM that runs Grunt and integrates with Travis CI, HipChat and Cachet

Learn how a Puppet provisioned Vagrant VM can abstract Node.js-based workflows away from a developer's machine, and into a structured, testable, continuous-integration environment.

### Components
This project makes use of the following packages, services and software: 

* [Vagrant](https://www.vagrantup.com/)  
* [Puppet](https://puppetlabs.com/)  
* [Node.js](https://nodejs.org/en/)  
* [Yeoman](http://yeoman.io/)  
* [Grunt](http://gruntjs.com/)  
* [Bower](http://bower.io/)  
* [generator-zf5](https://github.com/juliancwirko/generator-zf5)  
* [Zurb Foundation 5](http://foundation.zurb.com/)  
* [Travis CI](https://travis-ci.org/)  
* [HipChat](https://www.hipchat.com/)  
* [Hubot](https://hubot.github.com/)  
* [Hubot Cachethq](https://www.npmjs.com/package/hubot-cachethq)  
* [Cachet](https://cachethq.io/)  

### Requirements
[Vagrant](https://www.vagrantup.com/) must be installed on the computers you wish to run the local VMs.  

### Gotchas
Hostnames will need to be changed in [bootstrap-master.sh](https://github.com/tommymcgahee/puppet-and-ci-managed-dev-environments/blob/puppet-master-foreman/bootstrap-master.sh) and [bootstrap-agent.sh](https://github.com/tommymcgahee/puppet-and-ci-managed-dev-environments/blob/master/bootstrap-agent.sh). DHCP or local host files should match.  

Production URL and Git config options need to be changed in [deploy.sh](https://github.com/tommymcgahee/puppet-and-ci-managed-dev-environments/blob/master/.travis/deploy.sh). 

New SSH id_rsa deploy key pair will need to be generated and encrypted. See [encryping-fiiles](http://docs.travis-ci.com/user/encrypting-files/) for more information on encrypting files with Travis CI.  

New HipChat room and token will need to be created.  Encrypted token will need to be inserted into [.travis.yml](https://github.com/tommymcgahee/puppet-and-ci-managed-dev-environments/blob/master/.travis.yml) (lines 21-24). See [HipChat-notification](http://docs.travis-ci.com/user/notifications/#HipChat-notification) for information on encrypting tokens with Travis CI.  

Hubot will need to be updated with new HipChat and Cachet tokens, IDs and URLs in [hubot.conf](https://github.com/tommymcgahee/puppet-and-ci-managed-dev-environments/blob/hubot/hubot.conf).

### Branch Overview

#### Puppet Master Foreman
Provides all needed files to stand up a local, Cent OS 6 VM as a Puppet Master with Foreman as its ENC.

#### Master 
Provides all needed files to stand up a local, Cent OS 6 VM as a Puppet Agent with the [ZF5](https://github.com/juliancwirko/generator-zf5) generator installed and ready for development work.  

#### Hubot
Version controlled Hubot configuration.

### Workflow
![Image of project workflow. Steps include Remote Git Repo, Developer Machine, Local Vagrant VM - Puppet Agent, CI and Deployment, Production, HIpChat, and Status Page](https://raw.githubusercontent.com/tommymcgahee/puppet-and-ci-managed-dev-environments/master/flowchart-github.jpg)  

### License

[MIT License](http://en.wikipedia.org/wiki/MIT_License)
