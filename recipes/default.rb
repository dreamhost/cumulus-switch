#
# Cookbook Name:: cumulusvx
# Recipe:: default
#
# Copyright 2015, DreamHost
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'cumulus'

cumulus_ports 'speeds' do
  speed_10g ['swp1-50']
  notifies :restart, "service[switchd]"
end
