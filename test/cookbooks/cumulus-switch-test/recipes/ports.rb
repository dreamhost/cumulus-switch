#
# Cookbook Name:: cumulus-switch-test
# Recipe:: ports
#
node.set['cumulus']['ports']['10g'] = ['swp1']
node.set['cumulus']['ports']['40g'] = ['swp2-3']
node.set['cumulus']['ports']['40g_div_4'] = ['swp4', 'swp5']
node.set['cumulus']['ports']['4_by_10g'] = ['swp6', 'swp7-8']
