#
# Cookbook Name:: cumulus-application-example
# Recipe:: leaf
#
# Copyright 2015, DreamHost
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'cumulus'

cumulus_interface "eth0"

# setup swp*
(1..34).each do |int|
  cumulus_interface "swp#{int}" do
    speed '10000'
    mtu 9000
  end
end

# configure uplinks
cumulus_interface 'swp33' do
  ipv4 ['10.66.0.2/24']
  speed '10000'
  mtu 9000
  notifies :reload, "service[networking]", :delayed
end

cumulus_interface 'swp34' do
  ipv4 ['10.66.0.3/24']
  speed '10000'
  mtu 9000
  notifies :reload, "service[networking]", :delayed
end

# set speed on swp* ports
cumulus_ports 'speeds' do
  speed_10g ['swp1-34']
  notifies :restart, "service[switchd]"
end

cumulus_bridge 'br-cust' do
  ports ['swp1-12']
  ipv4 ['10.65.10.1/24']
  alias_name 'customer'
  mtu 9000
  notifies :reload, "service[networking]", :delayed
end

cumulus_bridge 'br-mgt' do
  ports ['swp13-24']
  ipv4 ['10.65.11.1/24']
  ipv6 ['2001:db8:abcd::/48']
  alias_name 'management'
  mtu 9000
  notifies :reload, "service[networking]", :delayed
end
