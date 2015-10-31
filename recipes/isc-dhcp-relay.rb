#
# Cookbook Name:: cumulus-application-example
# Recipe:: isc-dhcp-relay
#
# Copyright 2015, DreamHost
#
# All rights reserved - Do Not Redistribute
#
# Servers are seperated with a space, as well as interfaces
if node['dhcp_relay']
  servers    = node['dhcp_relay']['servers']
  interfaces = node['dhcp_relay']['interfaces']

  template "/etc/default/isc-dhcp-relay" do
    source "isc-dhcp-relay.erb"
    variables({
      :servers    => servers,
      :interfaces => interfaces
    })
  end
  service "isc-dhcp-relay" do
      action :restart
  end
end
