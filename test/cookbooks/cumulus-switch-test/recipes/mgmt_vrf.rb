#
# Cookbook Name:: cumulus-switch-test
# Recipe:: mgmt_vrf
#
if node['lsb']['release'] =~ /^3\./
  # TODO: Is there some way to reliably test Management VRF with CL 3? I just get disconnected during the chef run.
  #include_recipe 'cumulus-switch::mgmt_vrf'
else
  node.set['cumulus']['mgmt_vrf']['enabled'] = true
  node.set['cumulus']['mgmt_vrf']['restart_quagga'] = true
end

