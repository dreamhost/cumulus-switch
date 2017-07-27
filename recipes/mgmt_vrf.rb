#
# Cookbook Name:: cumulus-switch
# Recipe:: mgmt_vrf
#
# Copyright 2015, DreamHost
#
include_recipe 'cumulus-switch'

enabled = node['cumulus']['mgmt_vrf']['enabled']
restart_quagga = node['cumulus']['mgmt_vrf']['restart_quagga']

service 'quagga' do
  supports restart: true
  action :nothing
end

execute 'cl-mgmtvrf-enable' do
  command 'cl-mgmtvrf --enable'
  action :nothing
end

execute 'cl-mgmtvrf-disable' do
  command 'cl-mgmtvrf --disable'
  action :nothing
end

release = node['lsb']['release']

case release
when /^3\./
  node.default['cumulus']['interface']['eth0']['vrf'] = 'mgmt'
  node.default['cumulus']['interface']['mgmt']['ipv4'] = ['127.1.0.1/16']
  node.default['cumulus']['interface']['mgmt']['vrf_table'] = 'auto'
  include_recipe 'cumulus-switch::base'
else
  if enabled
    Chef::Log.info('Enabling Management VRF')
    # Update repo and install cl-mgmtvrf
    execute 'apt-get update'
    package 'cl-mgmtvrf' do
      action :install
      notifies :run, 'execute[cl-mgmtvrf-enable]', :immediately
      notifies :restart, 'service[quagga]', :delayed if restart_quagga
    end
  elsif enabled == false
    Chef::Log.info('Disabling Management VRF')
    # Update repo and install cl-mgmtvrf
    execute 'apt-get update'
    package 'cl-mgmtvrf' do
      action :remove
      notifies :run, 'execute[cl-mgmtvrf-disable]', :immediately
      notifies :restart, 'service[quagga]', :delayed if restart_quagga
    end
  end
end
