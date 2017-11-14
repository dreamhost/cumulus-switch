#
# Cookbook Name:: cumulus-test
# Recipe:: license
#
# Copyright 2015, Cumulus Networks
#
# All rights reserved - Do Not Redistribute
#

cookbook_file '/tmp/test.v1' do
  source 'test_noeula.v1'
end

cumulus_license 'test' do
  source 'file:///tmp/test.v1'
end

cumulus_license 'test-with-force' do
  source 'file:///tmp/test.v1'
  force true
end
