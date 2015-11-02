#
# Cookbook Name:: cumulus-application-example
# Recipe:: leaf
#
# Copyright 2015, DreamHost
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'cumulus'

# Notifying the networking service to reload doesn't work
# for some reason ('up to date'), so we're getting the
# desired results by notifying this instead
execute 'reload_networking' do
  command 'service networking reload'
  action :nothing
end

# service networking reload does not clear any old loopback
# addresses.  We must ifdown & ifup the lo interface.
execute 'reload_loopback' do
  command 'ifdown lo && ifup lo'
  action :nothing
end

def cl_interface(interface, data)
  cumulus_interface interface do
    ipv4 data.ipv4 if data['ipv4']
    ipv6 data.ipv6 if data['ipv6']
    speed data.speed if data['speed']
    mtu data.mtu if data['mtu']
    post_up data.post_up if data['post_up']
    addr_method data.addr_method if data['addr_method']
    # Options for enabling clagd ports
    clagd_enable data.clagd_enable if data['clagd_enable']
    clagd_peer_ip data.clagd_peer_ip if data['clagd_peer_ip']
    clagd_priority data.clagd_priority if data['clagd_priority']
    clagd_sys_mac data.clagd_sys_mac if data['clagd_sys_mac']
    notifies :run, "execute[reload_networking]", :delayed
    notifies :run, "execute[reload_loopback]", :delayed if interface =~ /^lo/
  end
end

# Bond
node.cumulus_attr.bond.each do |bond, data|
  cumulus_bond bond do
    ipv4 data.ipv4 if data['ipv4']
    ipv6 data.ipv6 if data['ipv6']
    slaves data.slaves if data['slaves']
    clag_id data.clag_id if data['clag_id']
    lacp_bypass_allow data.lacp_bypass_allow if data['lacp_bypass_allow']
    virtual_ip data.virtual_ip if data['virtual_ip']
    notifies :run, "execute[reload_networking]", :delayed
  end
end

# Bridges
node.cumulus_attr.bridge.each do |bridge, data|
  cumulus_bridge bridge do
    ports data.ports if data['ports']
    ipv4 data.ipv4 if data['ipv4']
    ipv6 data.ipv6 if data['ipv6']
    virtual_ip data.virtual_ip if data['virtual_ip']
    virtual_mac data.virtual_mac if data['virtual_mac']
    stp data.stp unless data['stp'].nil?
    notifies :run, "execute[reload_networking]", :delayed
  end
end

# Interfaces
node.cumulus_attr.interface.each do |interface, data|
  cl_interface(interface, data)
end

# Interface ranges
node.cumulus_attr.interface_range.each do |range_str, data|
  # range str should be something like "swp[1-24].100"
  range = range_str.match(/\[(\d+)-(\d+)\]/)
  (range[1]..range[2]).each do |id|
    ifname = range_str.gsub(/\[\d+-\d+\]/, id)
    cl_interface(ifname, data)
  end
end

# Ports
cumulus_ports 'speeds' do
  speed_10g node.cumulus_attr.ports['10g'] if node.cumulus_attr.ports['10g']
  speed_40g node.cumulus_attr.ports['40g'] if node.cumulus_attr.ports['40g']
  speed_40g_div_4 node.cumulus_attr.ports['40g_div_4'] if node.cumulus_attr.ports['40g_div_4']
  speed_4_by_10g node.cumulus_attr.ports['4_by_10g'] if node.cumulus_attr.ports['4_by_10g']
  notifies :restart, "service[switchd]", :delayed if node.cumulus_attr.restart_switchd
end
