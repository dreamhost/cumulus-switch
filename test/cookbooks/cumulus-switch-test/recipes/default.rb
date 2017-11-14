#
# Cookbook Name:: cumulus-switch-test
# Recipe:: default
#

# Setup a skeleton fake Cumulus Linux environment
file '/usr/cumulus/bin/cl-license' do
  content '#!/bin/sh
    echo "Rocket Turtle!\nexpires=$(date +%s)\n$0 $@" > /etc/cumulus/.license.txt'
  mode '0755'
end

node.set['cumulus']['reload_networking'] = false

include_recipe 'cumulus-switch-test::ports'
include_recipe 'cumulus-switch-test::license'
include_recipe 'cumulus-switch-test::interface_policy'
include_recipe 'cumulus-switch-test::bonds'
include_recipe 'cumulus-switch-test::bridges'
include_recipe 'cumulus-switch-test::interfaces'
include_recipe 'cumulus-switch-test::mgmt_vrf'

include_recipe 'cumulus-switch::base'
include_recipe 'cumulus-switch::mgmt_vrf'
include_recipe 'cumulus-switch::license'
