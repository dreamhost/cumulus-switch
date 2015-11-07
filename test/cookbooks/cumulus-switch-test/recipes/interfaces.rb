#
# Cookbook Name:: cumulus-switch-test
# Recipe:: interfaces
#

# With all defaults
node.set[:cumulus][:interface]['swp1']

# Over-ride defaults
node.set[:cumulus][:interface]['swp2']['ipv4'] = ['192.168.200.1']
node.set[:cumulus][:interface]['swp2']['ipv6'] = ['2001:db8:5678::']
node.set[:cumulus][:interface]['swp2']['addr_method'] = 'static'
node.set[:cumulus][:interface]['swp2']['speed'] = '1000'
node.set[:cumulus][:interface]['swp2']['mtu'] = 9000
node.set[:cumulus][:interface]['swp2']['clagd_enable'] = true
node.set[:cumulus][:interface]['swp2']['clagd_priority'] = 1
node.set[:cumulus][:interface]['swp2']['clagd_peer_ip'] = '10.1.2.3'
node.set[:cumulus][:interface]['swp2']['clagd_sys_mac'] = 'aa:bb:cc:dd:ee:ff'
#node.set[:cumulus][:interface]['swp2']['vids'] = ['1-4094']
#node.set[:cumulus][:interface]['swp2']['pvid'] = 1
#node.set[:cumulus][:interface]['swp2']['alias_name'] = 'interface swp2'
#node.set[:cumulus][:interface]['swp2']['virtual_mac'] = '11:22:33:44:55:66'
#node.set[:cumulus][:interface]['swp2']['virtual_ip'] = '192.168.10.1'
node.set[:cumulus][:interface]['swp2']['mstpctl_portnetwork'] = true
node.set[:cumulus][:interface]['swp2']['mstpctl_portadminedge'] = true
node.set[:cumulus][:interface]['swp2']['mstpctl_bpduguard'] = true
node.set[:cumulus][:interface]['swp2']['post_up'] = [
  "ip route add 10.0.0.0/8 via 192.168.200.2",
  "ip route add 172.16.0.0/12 via 192.168.200.2"
]
#node.set[:cumulus][:interface]['swp2']['pre_down'] = [
#  "ip route del 10.0.0.0/8 via 192.168.200.2",
#  "ip route del 172.16.0.0/12 via 192.168.200.2"
#]

# Test post_up and pre_down as String instead of Array
node.set[:cumulus][:interface]['swp3']['post_up'] = "ip route add 192.168.0.0/16 via 192.168.200.2"
#node.set[:cumulus][:interface]['swp3']['pre_down'] = "ip route del 192.168.0.0/16 via 192.168.200.2"
