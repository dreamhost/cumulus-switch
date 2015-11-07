#
# Cookbook Name:: cumulus-switch-test
# Recipe:: bridges
#

node.set[:cumulus][:bridge]['br0']['ports'] = ['swp9', 'swp10-11', 'swp12']

node.set[:cumulus][:bridge]['br1']['ports'] = ['swp13-14']
node.set[:cumulus][:bridge]['br1']['ipv4'] = ['10.0.0.1/24', '192.168.1.0/16']
node.set[:cumulus][:bridge]['br1']['ipv6'] = ['2001:db8:abcd::/48']
node.set[:cumulus][:bridge]['br1']['virtual_ip'] = '192.168.100.1'
node.set[:cumulus][:bridge]['br1']['virtual_mac'] = 
node.set[:cumulus][:bridge]['br1']['stp'] = false
#node.set[:cumulus][:bridge]['br1']['mtu'] = 9000
#node.set[:cumulus][:bridge]['br1']['mstpctl_treeprio'] = 4096
#node.set[:cumulus][:bridge]['br1']['alias'] = 'classic bridge number 1'

# New bridge driver all defaults
node.set[:cumulus][:bridge]['bridge2']['ports'] = ['swp15-16']
#node.set[:cumulus][:bridge]['bridge2']['vlan_aware'] = true

# New bridge driver over-ride
node.set[:cumulus][:bridge]['bridge3']['ports'] = ['swp17-18']
#node.set[:cumulus][:bridge]['bridge3']['vlan_aware'] = true
#node.set[:cumulus][:bridge]['bridge3']['vids'] = ['1-4094']
#node.set[:cumulus][:bridge]['bridge3']['pvid'] = 1
node.set[:cumulus][:bridge]['bridge3']['ipv4'] = ['10.0.100.1/24', '192.168.100.0/16']
node.set[:cumulus][:bridge]['bridge3']['ipv6'] = ['2001:db8:1234::/48']
#node.set[:cumulus][:bridge]['bridge3']['alias_name'] = 'new bridge number 3'
#node.set[:cumulus][:bridge]['bridge3']['mtu'] = 9000
node.set[:cumulus][:bridge]['bridge3']['stp'] = false
#node.set[:cumulus][:bridge]['bridge3']['mstpctl_treeprio'] = 4096
#node.set[:cumulus][:bridge]['bridge3']['virtual_mac'] = 'aa:bb:cc:dd:ee:ff'
#node.set[:cumulus][:bridge]['bridge3']['post_up'] = [
#  "ip route add 10.0.0.0/8 via 192.168.200.2",
#  "ip route add 172.16.0.0/12 via 192.168.200.2"
#]
#node.set[:cumulus][:bridge]['bridge3']['pre_down'] = [
#  "ip route del 10.0.0.0/8 via 192.168.200.2",
#  "ip route del 172.16.0.0/12 via 192.168.200.2"
#]
