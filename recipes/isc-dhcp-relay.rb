#
# Cookbook Name:: cumulus-switch
# Recipe:: dhcp-relay
#
# Copyright 2015, DreamHost
#
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
    notifies :restart, 'service[isc-dhcp-relay]', :delayed
  end
  service 'isc-dhcp-relay'
end
