maintainer        "Holger Just"
maintainer_email  "hjust@meine-er.de"
license           "Apache 2.0"
description       "Installs an OpenSSH client or server"
version           "0.8.1"

recipe "openssh", "Installs an OpenSSH server"
recipe "openssh::client", "Installs the OpenSSH client software"
recipe "openssh::server", "Installs an OpenSSH server"

%w{ redhat centos fedora ubuntu debian arch}.each do |os|
  supports os
end

attribute "ssh",
  :display_name => "OpenSSH",
  :description => "Hash of OpenSSH attributes",
  :type => "hash"

attribute "ssh/listen_interfaces",
  :display_name => "Listen Interfaces",
  :description => "Listen on all addresses of this interfaces",
  :recipes => ["ssh::server"],
  :type => "array",
  :default => []

attribute "ssh/listen_interfaces",
  :display_name => "Listen Addresses",
  :description => "Listen on these addresses",
  :recipes => ["ssh::server"],
  :type => "array",
  :default => []

attribute "ssh/listen_port",
  :display_name => "Listen Port",
  :description => "Port the server is listening to",
  :recipes => ["ssh::server"],
  :type => "string",
  :default => "22"

attribute "ssh/permit_root_login",
  :display_name => "Permit root login",
  :description => "if true, permit root login",
  :recipes => ["ssh::server"],
  :type => "string",
  :default => "false"

attribute "ssh/password_authentication",
  :display_name => "Permit password authentication",
  :description => "if true, permit password authentication",
  :recipes => ["ssh::server"],
  :type => "string",
  :default => "false"

attribute "ssh/authorized_keys_file",
  :display_name => "Authorized keys file",
  :description => "Location of the authorized keys file",
  :recipes => ["ssh::server"],
  :type => "string",
  :default => "%h/.ssh/authorized_keys"