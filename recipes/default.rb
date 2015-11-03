#
# Cookbook Name:: cumulus-switch
# Recipe:: default
#
# Copyright 2015, DreamHost
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
