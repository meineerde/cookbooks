#
# Cookbook Name:: openssh
# Recipe:: default
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

default[:ssh][:listen_interfaces] = []
default[:ssh][:listen_addresses] = []
default[:ssh][:listen_port] = "22"

default[:ssh][:permit_root_login] = 'false'
default[:ssh][:password_authentication] = 'false'

default[:ssh][:authorized_keys_file] = '%h/.ssh/authorized_keys'
