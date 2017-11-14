#
# Cookbook Name:: cumulus-test
# Recipe:: license
#
# Copyright 2015, Cumulus Networks
#
# All rights reserved - Do Not Redistribute
#

cookbook_file '/tmp/test.lic' do
  source 'test.lic'
end

node.set['cumulus']['license'] = 'file:///tmp/test.lic'
