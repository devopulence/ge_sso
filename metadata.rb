name             'ge_sso'
maintainer       'GE Capital'
maintainer_email 'john.desposito@ge.com'
license          'All rights reserved'
description      'Installs/Configures ge_sso'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'



depends "ge_iptables"
depends "ge_selinux"
depends "ge_apache", "~> 0.1.7"

