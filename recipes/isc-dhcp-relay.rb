#
# Cookbook Name:: cumulus-switch
# Recipe:: dhcp-relay
#
# Copyright 2015, DreamHost
#

release = node['lsb']['release']
case release
when /^3\./
  relay_service = 'dhcrelay'
else
  relay_service = 'isc-dhcp-relay'
end

if node['dhcp_relay']
  # Servers are seperated with a space, as well as interfaces
  servers = node['dhcp_relay']['servers']
  interfaces = node['dhcp_relay']['interfaces']

  template '/etc/default/isc-dhcp-relay' do
    source 'isc-dhcp-relay.erb'
    variables(
      servers: servers,
      interfaces: interfaces
    )
    notifies :restart, "service[#{relay_service}]", :delayed
  end
  service relay_service do
    action [:enable, :start]
  end
end
