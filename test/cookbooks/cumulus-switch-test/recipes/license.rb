#
# Cookbook Name:: cumulus-switch-test
# Recipe:: license
#

cookbook_file '/tmp/test.lic' do
  source 'test.lic'
end

node.set['cumulus']['license'] = 'file:///tmp/test.lic'
