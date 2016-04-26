#
# Cookbook Name:: cumulus-switch
# Recipe:: base
#
# Copyright 2015, DreamHost
#
include_recipe 'cumulus-switch'

# cl_interface is used for interface ranges and individual interfaces
def cl_interface(interface, data, range=nil)
  cumulus_switch_interface interface do
    range range if range

    notifies :run, 'execute[reload_networking]', :delayed if node.cumulus.reload_networking
    notifies :run, 'execute[reload_loopback]', :delayed if interface =~ /^lo/
  end
end

# Interfaces
node.cumulus.interface.each do |interface, data|
  cl_interface(interface, data)
end

# Interface ranges
node.cumulus.interface_range.each do |range_str, data|
  # range str should be something like 'swp[1-24].100' or 'swp[2-5]'
  range = range_str.match(/\[(\d+)-(\d+)\]/)
  (range[1]..range[2]).each do |id|
    ifname = range_str.gsub(/\[\d+-\d+\]/, id)
    cl_interface(ifname, data, range_str)
  end
end

# Bond
node.cumulus.bond.each do |bond, data|
  cumulus_switch_bond bond do
    notifies :run, 'execute[reload_networking]', :delayed if node.cumulus.reload_networking
  end
end

# Bridges
node.cumulus.bridge.each do |bridge, data|
  cumulus_switch_bridge bridge do
    notifies :run, 'execute[reload_networking]', :delayed if node.cumulus.reload_networking
  end
end

# Ports
cumulus_switch_ports 'speeds' do
  notifies :restart, 'service[switchd]', :delayed if node.cumulus.restart_switchd
end
