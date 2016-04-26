#
# Cookbook Name:: cumulus-switch
# Recipe:: interfaces
#
# Copyright 2015, Cumulus Networks
# Copyright 2016, DreamHost
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
service 'networking' do
  supports :status => true, :restart => true, :reload => true
  action :nothing
end

# Create the configuration fragments directory
location = node['cumulus']['interfaces']['dir']

directory location do
  owner 'root'
  group 'root'
  action :create
end

# Copy the configuration for eth0 & lo interfaces into fragments
%w( eth0 lo ).each do |intf|
  config = ::File.join(location, intf)
  execute "#{intf} config" do
    command "ifquery #{intf} > #{config}"
    not_if { ::File.exists?(config) }
    notifies :reload, 'service[networking]'
  end
end

# Replace interfaces file with one that uses the fragments
file '/etc/network/interfaces' do
  owner 'root'
  group 'root'
  mode '0644'
  content "# This file is managed by Chef\nsource #{::File.join(location, '*')}"
  notifies :reload, 'service[networking]'
end
