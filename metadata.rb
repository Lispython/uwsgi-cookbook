name             "uwsgi"
maintainer       "Alexandr Lispython"
maintainer_email "alex@obout.ru"
license          "BSD, see LICENSE for more details."
description      "Install/Configures uwsgi spplications"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.3"


%w[ debian ubuntu].each do |os|
  supports os
end

recipe "default", "Default recipe"

depends "python"
