maintainer        "Holger Just"
maintainer_email  "hjust@meine-er.de"
license           "Apache 2.0"
description       "Installs and configures ntp as a client or server"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.0.0"

recipe "ntp", "Installs and configures ntp either as a server or client"

%w{ ubuntu debian redhat centos fedora }.each do |os|
  supports os
end

attribute "ntp",
  :display_name => "NTP",
  :description => "Hash of NTP attributes",
  :type => "hash"

attribute "ntp/service",
  :display_name => "NTP Service",
  :description => "Name of the NTP service",
  :default => "ntp"

attribute "ntp/servers",
  :display_name => "NTP Servers",
  :description => "Array of servers we should talk to",
  :type => "array",
  :default => ["0.pool.ntp.org", "1.pool.ntp.org"]

attribute "ntp/server_search",
  :display_name => "NTP Server Search",
  :description => "Node search query to find upstream servers. Overrides ntp/servers if set",
  :type => "string",
  :default => ""
