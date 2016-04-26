#
# Cookbook Name:: cumulus-switch-test
# Recipe:: bonds
#
node.set['cumulus']['bond']['bond0']['slaves'] = ['swp1-2', 'swp4']

node.set[:cumulus][:bond]['bond1']['slaves'] = ['swp5-6']
node.set[:cumulus][:bond]['bond1']['ipv4'] = ['10.0.0.1/24', '192.168.1.0/16']
node.set[:cumulus][:bond]['bond1']['ipv6'] = ['2001:db8:abcd::/48']
node.set[:cumulus][:bond]['bond1']['clag_id'] = 1
node.set[:cumulus][:bond]['bond1']['lacp_bypass_allow'] = 1
node.set[:cumulus][:bond]['bond1']['lacp_bypass_period'] = 30
node.set[:cumulus][:bond]['bond1']['lacp_bypass_all_active'] = 1
node.set[:cumulus][:bond]['bond1']['virtual_ip'] = '192.168.20.1'
node.set[:cumulus][:bond]['bond1']['virtual_mac'] = '11:22:33:44:55:FF'
node.set[:cumulus][:bond]['bond1']['mstpctl_portnetwork'] = true
node.set[:cumulus][:bond]['bond1']['mstpctl_portadminedge'] = true
node.set[:cumulus][:bond]['bond1']['mstpctl_bpduguard'] = true
node.set[:cumulus][:bond]['bond1']['alias'] = 'bond number 1'
node.set[:cumulus][:bond]['bond1']['addr_method'] = 'static'
node.set[:cumulus][:bond]['bond1']['min_links'] = 2
node.set[:cumulus][:bond]['bond1']['mode'] = 'balance-alb'
node.set[:cumulus][:bond]['bond1']['miimon'] = 99
node.set[:cumulus][:bond]['bond1']['xmit_hash_policy'] = 'layer2'
node.set[:cumulus][:bond]['bond1']['lacp_rate'] = 9
node.set[:cumulus][:bond]['bond1']['mtu'] = 9000
node.set[:cumulus][:bond]['bond1']['clag_id'] = 1
node.set[:cumulus][:bond]['bond1']['vids'] = ['1-4094']
node.set[:cumulus][:bond]['bond1']['pvid'] = 1
node.set[:cumulus][:bond]['bond1']['post_up'] = [
  "ip route add 10.0.0.0/8 via 192.168.200.2",
  "ip route add 172.16.0.0/12 via 192.168.200.2"
]
node.set[:cumulus][:bond]['bond1']['pre_down'] = [
  "ip route del 10.0.0.0/8 via 192.168.200.2",
  "ip route del 172.16.0.0/12 via 192.168.200.2"
]

node.set[:cumulus][:bond]['bond2']['slaves'] = ['swp7', 'swp8']
node.set[:cumulus][:bond]['bond2']['virtual_ip'] = '11:22:33:44:55:FF 192.168.20.1'
node.set[:cumulus][:bond]['bond2']['lacp_bypass_allow'] = 1
node.set[:cumulus][:bond]['bond2']['lacp_bypass_priority'] = ['swp7=10 swp8=5']
