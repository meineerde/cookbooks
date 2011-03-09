#
# Cookbook Name:: openssh
# Recipe:: server
# Author:: Holger Just <hjust@meine-er.de>
#
# Copyright 2011, Holger Just
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "openssh::client"

case node[:platform]
when "centos","redhat","fedora"
  package "openssh"
when "arch"
  package "openssh"
else
  package "openssh-server"
end
  
service "ssh" do
  case node[:platform]
  when "centos","redhat","fedora","arch"
    service_name "sshd"
  else
    service_name "ssh"
  end
  supports value_for_platform(
    "debian" => { "default" => [ :restart, :reload, :status ] },
    "ubuntu" => {
      "8.04" => [ :restart, :reload ],
      "default" => [ :restart, :reload, :status ]
    },
    "centos" => { "default" => [ :restart, :reload, :status ] },
    "redhat" => { "default" => [ :restart, :reload, :status ] },
    "fedora" => { "default" => [ :restart, :reload, :status ] },
    "arch" => { "default" => [ :restart ] },
    "default" => { "default" => [:restart, :reload ] }
  )
  action [ :enable, :start ]
end

# detect listen addresses from interfaces
listen_addresses = node['ssh']['listen_interfaces'].collect do |interface|
  interface = node['network']['default_interface'] if interface.to_s == 'default'
  
  node['network']['interfaces'][interface]['addresses'].collect do |addr, info|
    addr if %w(inet inet6).include? info['family']
  end.compact
end.flatten.uniq

listen_addresses += node['ssh']['listen_addresses']

template "/etc/ssh/sshd_config" do
  source "sshd_config.erb"
  owner "root"
  group "root"
  mode 0640
  variables :listen_addresses => listen_addresses
  notifies :restart, resources(:service => "ssh")
end

