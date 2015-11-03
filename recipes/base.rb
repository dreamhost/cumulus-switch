#
# Cookbook Name:: cumulus-switch
# Recipe:: base
#
# Copyright 2015, DreamHost
#
include_recipe 'cumulus-switch'

# cl_interface is used for interface ranges and individual interfaces
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
    mstpctl_portnetwork data.mstpctl_portnetwork unless data['mstpctl_portnetwork'].nil?
    mstpctl_portadminedge data.mstpctl_portadminedge unless data['mstpctl_portadminedge'].nil?
    mstpctl_bpduguard data.mstpctl_bpduguard unless data['mstpctl_bpduguard'].nil?
    notifies :run, "execute[reload_networking]", :delayed
    notifies :run, "execute[reload_loopback]", :delayed if interface =~ /^lo/
  end
end

# Interfaces
node.cumulus.interface.each do |interface, data|
  cl_interface(interface, data)
end

# Interface ranges
node.cumulus.interface_range.each do |range_str, data|
  # range str should be something like "swp[1-24].100" or "swp[2-5]"
  range = range_str.match(/\[(\d+)-(\d+)\]/)
  (range[1]..range[2]).each do |id|
    ifname = range_str.gsub(/\[\d+-\d+\]/, id)
    cl_interface(ifname, data)
  end
end

# Bond
node.cumulus.bond.each do |bond, data|
  cumulus_bond bond do
    ipv4 data.ipv4 if data['ipv4']
    ipv6 data.ipv6 if data['ipv6']
    slaves data.slaves if data['slaves']
    clag_id data.clag_id if data['clag_id']
    lacp_bypass_allow data.lacp_bypass_allow if data['lacp_bypass_allow']
    virtual_ip data.virtual_ip if data['virtual_ip']
    mstpctl_portnetwork data.mstpctl_portnetwork unless data['mstpctl_portnetwork'].nil?
    mstpctl_portadminedge data.mstpctl_portadminedge unless data['mstpctl_portadminedge'].nil?
    mstpctl_bpduguard data.mstpctl_bpduguard unless data['mstpctl_bpduguard'].nil?
    notifies :run, "execute[reload_networking]", :delayed
  end
end

# Bridges
node.cumulus.bridge.each do |bridge, data|
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

# Ports
cumulus_ports 'speeds' do
  speed_10g node.cumulus.ports['10g'] if node.cumulus.ports['10g']
  speed_40g node.cumulus.ports['40g'] if node.cumulus.ports['40g']
  speed_40g_div_4 node.cumulus.ports['40g_div_4'] if node.cumulus.ports['40g_div_4']
  speed_4_by_10g node.cumulus.ports['4_by_10g'] if node.cumulus.ports['4_by_10g']
  notifies :restart, "service[switchd]", :delayed if node.cumulus.restart_switchd
end
