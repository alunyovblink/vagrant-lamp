name             'base_setup'
maintainer       'Blinkreaction'
maintainer_email 'alexandr.lunyov@blinkreaction.com'
license          'All rights reserved'
description      'Installs/Configures base_setup'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "apache2"
depends "mysql"
depends "php"