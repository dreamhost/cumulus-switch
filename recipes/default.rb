#
# Cookbook Name:: cumulus-application-example
# Recipe:: leaf
#
# Copyright 2015, DreamHost
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'cumulus'

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

# Ports
cumulus_ports 'speeds' do
  speed_10g node.dh_network.ports['10g'] if node.dh_network.ports['10g']
  speed_40g node.dh_network.ports['40g'] if node.dh_network.ports['40g']
  speed_40_div_4 node.dh_network.ports['40_div_4'] if node.dh_network.ports['40_div_4']
  speed_4_by_10g node.dh_network.ports['4_by_10g'] if node.dh_network.ports['4_by_10g']
  notifies :restart, "service[switchd]"
end
