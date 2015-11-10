#
# Cookbook Name:: cumulus-switch-test
# Recipe:: mgmt_vrf
#
node.set[:cumulus][:mgmt_vrf][:enabled] = true
node.set[:cumulus][:mgmt_vrf][:restart_quagga] = true
