#
# Cookbook Name:: cumulus-switch
# Recipe:: base
#
# Copyright 2015, DreamHost
#
include_recipe 'cumulus-switch'

# cl_interface is used for interface ranges and individual interfaces
def cl_interface(interface, range = nil)
  cumulus_switch_interface interface do
    range range if range

    notifies :run, 'execute[reload_networking]', :delayed if node['cumulus']['reload_networking']
    notifies :run, 'execute[reload_loopback]', :delayed if interface =~ /^lo/
  end
end

# Interfaces
node['cumulus']['interface'].keys.each do |interface|
  cl_interface(interface)
end

# Interface ranges
node['cumulus']['interface_range'].keys.each do |range_str|
  # range str should be something like 'swp[1-24].100' or 'swp[2-5]'
  range = range_str.match(/\[(\d+)-(\d+)\]/)
  (range[1]..range[2]).each do |id|
    ifname = range_str.gsub(/\[\d+-\d+\]/, id)
    cl_interface(ifname, range_str)
  end
end

# Bond
node['cumulus']['bond'].keys.each do |bond|
  cumulus_switch_bond bond do
    notifies :run, 'execute[reload_networking]', :delayed if node['cumulus']['reload_networking']
  end
end

# Bridges
node['cumulus']['bridge'].keys.each do |bridge|
  Chef::Log.debug("attempting configure bridge #{bridge}")
  cumulus_switch_bridge bridge do
    notifies :run, 'execute[reload_networking]', :delayed if node['cumulus']['reload_networking']
  end
end

# Ports
cumulus_switch_ports 'speeds' do
  notifies :restart, 'service[switchd]', :delayed if node['cumulus']['restart_switchd']
end

# Switchd config
release = node['lsb']['release']

case release
when /^[12]\./
  cumulus_switch_switchd 'switchd' do
    action :createv2
    unless node['cumulus']['switchd'].empty?
      notifies :restart, 'service[switchd]', :delayed if node['cumulus']['restart_switchd']
    end
  end
else
  cumulus_switch_switchd 'switchd' do
    action :create
    unless node['cumulus']['switchd'].empty?
      notifies :restart, 'service[switchd]', :delayed if node['cumulus']['restart_switchd']
    end
  end
end
