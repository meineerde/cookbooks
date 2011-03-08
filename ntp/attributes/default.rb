case platform 
when "ubuntu","debian"
  default[:ntp][:service] = "ntp"
when "redhat","centos","fedora"
  default[:ntp][:service] = "ntpd"
end

default[:ntp][:servers]         = (0..3).collect{|i| "#{i}.pool.ntp.org"}
# If this is set, the servers set is overridden
default[:ntp][:server_search]   = ""