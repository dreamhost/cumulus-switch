#
# Cookbook Name:: cumulus-application-example
# Recipe:: leaf
#
# Copyright 2015, DreamHost
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'cumulus'

node.default['dh_network']['bridge']['br_mgmt']['ipv4'] = ['10.6.1.1/24']
node.default['dh_network']['bridge']['br_mgmt']['ports'] = ['swp1-12']
node.default['dh_network']['bridge']['br_cust']['ipv6'] = ['2607:f298:4:d00d::1/64']
node.default['dh_network']['bridge']['br_cust']['ports'] = ['swp13-24']
node.default['dh_network']['interface_range']['swp[1-24]']['speed'] = '10000'
node.default['dh_network']['interface_range']['swp[1-24]']['mtu'] = 9000
node.default['dh_network']['interface']['eth0'] = {}
node.default['dh_network']['interface']['swp1']['speed'] = '10000'
node.default['dh_network']['interface']['swp1']['mtu'] = 9000
node.default['dh_network']['ports']['10g'] = ['swp1-24']

# Bridges
node.dh_network.bridge.each do |bridge, data|
  # Execute to notify later
  execute "ifup_#{bridge}" do
    command "ifup #{bridge}"
    action :nothing
  end

  cumulus_bridge bridge do
    ports data.ports if data['ports']
    ipv4 data.ipv4 if data['ipv4']
    ipv6 data.ipv6 if data['ipv6']
    #notifies :run, "execute[ifup_br-cust]", :delayed
    # This shit doesn't work with vagrant + virtualbox + cumulus vx
  end
end

# Interfaces
node.dh_network.interface.each do |interface, data|
  # Execute to notify later
  execute "ifup_#{interface}" do
    command "ifup #{interface}"
    action :nothing
  end

  cumulus_interface interface do
    ipv4 [data.ipv4] if data['ipv4']
    ipv4 [data.ipv6] if data['ipv6']
    speed data.speed if data['speed']
    mtu data.mtu if data['mtu']
    #notifies :run, "execute[ifup_#{interface}]", :delayed
    # This shit doesn't work with vagrant + virtualbox + cumulus vx
  end
end

# Interface ranges
node.dh_network.interface_range.each do |range_str, data|
  # range str should be something like "swp[1-24].100"
  range = range_str.match(/\[(\d+)-(\d+)\]/)
  (range[1]..range[2]).each do |id|
    ifname = range_str.gsub(/\[\d+-\d+\]/, id)

    # Execute to notify later
    execute "ifup_#{ifname}" do
      command "ifup #{ifname}"
      action :nothing
    end

    cumulus_interface ifname do
      speed data.speed if data['speed']
      mtu data.mtu if data['mtu']
      #notifies :run, "execute[ifup_#{ifname}]", :delayed
      # This shit doesn't work with vagrant + virtualbox + cumulus vx
    end
  end
end

# set speed on swp* ports
cumulus_ports 'speeds' do
  speed_10g node.dh_network.ports['10g'] if node.dh_network.ports['10g']
  notifies :restart, "service[switchd]"
end
