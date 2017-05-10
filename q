[1;33mdiff --git i/README.md w/README.md[m
[1;33mindex c8f32ae..0a7ed5c 100644[m
[1;33m--- i/README.md[m
[1;33m+++ w/README.md[m
[1;35m@@ -47,7 +47,7 @@[m [mAttributes[m
 NOTE! Where you see "String or Array" for type, a String may be used _only_ for single values.  Use [m
 an Array of Strings for multiple values.[m
 [m
[31m-NOTE! Tests for virtual_mac and virtual_ip are currently failing due to a bug in the [cumulus](https://github.com/CumulusNetworks/cumulus-linux-chef-modules) cookbook.  To use these attributes, place both in the virtual_ip attribute (`...[:virtual_ip] = 'AA:BB:CC:DD:EE:FF 10.0.0.1'`)[m
[32m+[m[32mNOTE! Tests for virtual_mac and virtual_ip are currently failing due to a bug in the [cumulus](https://github.com/CumulusNetworks/cumulus-linux-chef-modules) cookbook.  To use these attributes, place both in the virtual_ip attribute (`...['virtual_ip'] = 'AA:BB:CC:DD:EE:FF 10.0.0.1'`)[m
 [m
 cumulus-switch::base[m
 ---[m
[1;35m@@ -56,102 +56,102 @@[m [mcumulus-switch::base[m
 [m
 Attribute        | Description |Type | Default[m
 -----------------|-------------|-----|--------[m
[31m-`node[:cumulus][:interface]` | A hash of interfaces. Keys are the interface name, values are a hash with optional configuration. | Hash | `{}`[m
[31m-`node[:cumulus][:interface][$NAME]` | Configuration values for interface $NAME.  This will be the base for the following attributes. | Hash | `nil`[m
[31m-`[:ipv4]` | IPv4 address(s) to assign to the interface. | String or Array | `nil`[m
[31m-`[:ipv6]` | IPv6 address(s) to assign to the interface. | String or Array | `nil`[m
[31m-`[:alias]` | Interface alias (description). | String | `nil`[m
[31m-`[:speed]` | Speed to configure for the interface. | String | `nil`[m
[31m-`[:mtu]` | MTU to configure for the interface. | Integer | `nil`[m
[31m-`[:post_up]` | Post-up command(s) to run | String or Array | `nil`[m
[31m-`[:pre_down]` | Pre-down command(s) to run | String or Array | `nil`[m
[31m-`[:addr_method]` | Address assignment method, `dhcp` or `loopback`. | String | `nil`[m
[31m-`[:virtual_mac]` | VRR virtual MAC. | String | `nil`[m
[31m-`[:virtual_ip]` | VRR virtual IP. | String | `nil`[m
[31m-`[:vids]` | Array of VLANs to be configured for a VLAN aware trunk interface. | Array | `nil`[m
[31m-`[:pvid]` | Native VLAN for a VLAN aware trunk interface. | Integer | `nil`[m
[31m-`[:mstpctl_portnetwork]` | Enable bridge assurance on a VLAN aware trunk. | Boolean | `nil`[m
[31m-`[:mstpctl_portadminedge]` | Enables admin edge port. | Boolean | `nil`[m
[31m-`[:mstpctl_bpduguard]` | Enable BPDU guard on a VLAN aware trunk. | Boolean | `nil`[m
[31m-`[:clagd_enable]` | Enable CLAGD on the interface ([documentation](http://docs.cumulusnetworks.com/display/DOCS/Multi-Chassis+Link+Aggregation+-+MLAG)). | Boolean | `nil`[m
[31m-`[:clagd_peer_ip]` | Address of the CLAG peer switch | String | `nil`[m
[31m-`[:clagd_priority]` | CLAG priority for this switch | Integer | `nil`[m
[31m-`[:clagd_sys_mac]` | CLAG system MAC. The MAC must be identical on both of the CLAG peers. | String | `nil`[m
[31m-`[:clagd_args]` | Any additional arguments to be passed to the clagd deamon. | String | `nil`[m
[32m+[m[32m`node['cumulus']['interface']` | A hash of interfaces. Keys are the interface name, values are a hash with optional configuration. | Hash | `{}`[m
[32m+[m[32m`node['cumulus']['interface'][$NAME]` | Configuration values for interface $NAME.  This will be the base for the following attributes. | Hash | `nil`[m
[32m+[m[32m`['ipv4']` | IPv4 address(s) to assign to the interface. | String or Array | `nil`[m
[32m+[m[32m`['ipv6']` | IPv6 address(s) to assign to the interface. | String or Array | `nil`[m
[32m+[m[32m`['alias']` | Interface alias (description). | String | `nil`[m
[32m+[m[32m`['speed']` | Speed to configure for the interface. | String | `nil`[m
[32m+[m[32m`['mtu']` | MTU to configure for the interface. | Integer | `nil`[m
[32m+[m[32m`['post_up']` | Post-up command(s) to run | String or Array | `nil`[m
[32m+[m[32m`['pre_down']` | Pre-down command(s) to run | String or Array | `nil`[m
[32m+[m[32m`['addr_method']` | Address assignment method, `dhcp` or `loopback`. | String | `nil`[m
[32m+[m[32m`['virtual_mac']` | VRR virtual MAC. | String | `nil`[m
[32m+[m[32m`['virtual_ip']` | VRR virtual IP. | String | `nil`[m
[32m+[m[32m`['vids']` | Array of VLANs to be configured for a VLAN aware trunk interface. | Array | `nil`[m
[32m+[m[32m`['pvid']` | Native VLAN for a VLAN aware trunk interface. | Integer | `nil`[m
[32m+[m[32m`['mstpctl_portnetwork']` | Enable bridge assurance on a VLAN aware trunk. | Boolean | `nil`[m
[32m+[m[32m`['mstpctl_portadminedge']` | Enables admin edge port. | Boolean | `nil`[m
[32m+[m[32m`['mstpctl_bpduguard']` | Enable BPDU guard on a VLAN aware trunk. | Boolean | `nil`[m
[32m+[m[32m`['clagd_enable']` | Enable CLAGD on the interface ([documentation](http://docs.cumulusnetworks.com/display/DOCS/Multi-Chassis+Link+Aggregation+-+MLAG)). | Boolean | `nil`[m
[32m+[m[32m`['clagd_peer_ip']` | Address of the CLAG peer switch | String | `nil`[m
[32m+[m[32m`['clagd_priority']` | CLAG priority for this switch | Integer | `nil`[m
[32m+[m[32m`['clagd_sys_mac']` | CLAG system MAC. The MAC must be identical on both of the CLAG peers. | String | `nil`[m
[32m+[m[32m`['clagd_args']` | Any additional arguments to be passed to the clagd deamon. | String | `nil`[m
 [m
[31m-Note!  You can use all of the above attributes on `node[:cumulus][:interface_range][$NAME]` as well.  Use a a String in a format like `swp[1-24].100` or `swp[2-5]` for $NAME.[m
[32m+[m[32mNote!  You can use all of the above attributes on `node['cumulus']['interface_range'][$NAME]` as well.  Use a a String in a format like `swp[1-24].100` or `swp[2-5]` for $NAME.[m
 [m
 #### Bridges[m
 [m
 Attribute        | Description |Type | Default[m
 -----------------|-------------|-----|--------[m
[31m-`node[:cumulus][:bridge]` | A hash of bridges. Keys are the bridge name, values are a hash with configuration for the bridge. | Hash | `{}`[m
[31m-`node[:cumulus][:bridge][$NAME]` | Configuration values for bridge $NAME.  This will be the base for the following attributes. | Hash | `nil`[m
[31m-`[:ports]` | Interfaces to place in the bridge (*required*). | Array | `required`[m
[31m-`[:ipv4]` | IPv4 address(s) to assign to the bridge. | Array | `nil`[m
[31m-`[:ipv6]` | IPv6 address(s) to assign to the bridge. | Array | `nil`[m
[31m-`[:alias]` | Interface alias (description). | String | `nil`[m
[31m-`[:addr_method]` | Address assignment method, `dhcp` or `loopback`. | String | `nil`[m
[31m-`[:mtu]` | MTU to configure for the interface. | Integer | `nil`[m
[31m-`[:post_up]` | Post-up command(s) to run | String or Array | `nil`[m
[31m-`[:pre_down]` | Pre-down command(s) to run | String or Array | `nil`[m
[31m-`[:vids]` | Array of VLANs to be configured for a VLAN aware trunk interface. | Array | `nil`[m
[31m-`[:pvid]` | Native VLAN for a VLAN aware trunk interface. | Integer | `nil`[m
[31m-`[:vlan_aware]` | Use the VLAN aware bridge driver. | Boolean | `false`[m
[31m-`[:virtual_ip]` | VRR virtual IP ([documentation](http://docs.cumulusnetworks.com/display/DOCS/Virtual+Router+Redundancy+-+VRR)). | String | `nil`[m
[31m-`[:virtual_mac]` | VRR virtual MAC address ([documentation](http://docs.cumulusnetworks.com/display/DOCS/Virtual+Router+Redundancy+-+VRR)). | String | `nil`[m
[31m-`[:stp]` | Enable STP on the bridge. | Boolean | `true`[m
[31m-`[:mstp_treeprio]` | Bridge root priority. Must be multiple of 4096. | Integer | `nil`[m
[32m+[m[32m`node['cumulus']['bridge']` | A hash of bridges. Keys are the bridge name, values are a hash with configuration for the bridge. | Hash | `{}`[m
[32m+[m[32m`node['cumulus']['bridge'][$NAME]` | Configuration values for bridge $NAME.  This will be the base for the following attributes. | Hash | `nil`[m
[32m+[m[32m`['ports']` | Interfaces to place in the bridge (*required*). | Array | `required`[m
[32m+[m[32m`['ipv4']` | IPv4 address(s) to assign to the bridge. | Array | `nil`[m
[32m+[m[32m`['ipv6']` | IPv6 address(s) to assign to the bridge. | Array | `nil`[m
[32m+[m[32m`['alias']` | Interface alias (description). | String | `nil`[m
[32m+[m[32m`['addr_method']` | Address assignment method, `dhcp` or `loopback`. | String | `nil`[m
[32m+[m[32m`['mtu']` | MTU to configure for the interface. | Integer | `nil`[m
[32m+[m[32m`['post_up']` | Post-up command(s) to run | String or Array | `nil`[m
[32m+[m[32m`['pre_down']` | Pre-down command(s) to run | String or Array | `nil`[m
[32m+[m[32m`['vids']` | Array of VLANs to be configured for a VLAN aware trunk interface. | Array | `nil`[m
[32m+[m[32m`['pvid']` | Native VLAN for a VLAN aware trunk interface. | Integer | `nil`[m
[32m+[m[32m`['vlan_aware']` | Use the VLAN aware bridge driver. | Boolean | `false`[m
[32m+[m[32m`['virtual_ip']` | VRR virtual IP ([documentation](http://docs.cumulusnetworks.com/display/DOCS/Virtual+Router+Redundancy+-+VRR)). | String | `nil`[m
[32m+[m[32m`['virtual_mac']` | VRR virtual MAC address ([documentation](http://docs.cumulusnetworks.com/display/DOCS/Virtual+Router+Redundancy+-+VRR)). | String | `nil`[m
[32m+[m[32m`['stp']` | Enable STP on the bridge. | Boolean | `true`[m
[32m+[m[32m`['mstp_treeprio']` | Bridge root priority. Must be multiple of 4096. | Integer | `nil`[m
 [m
 #### Bonds[m
 [m
 Attribute        | Description |Type | Default[m
 -----------------|-------------|-----|--------[m
[31m-`node[:cumulus][:bond]` | A hash of bonds. Keys are the bond name, values are a hash with configuration for the bond. | Hash | `{}`[m
[31m-`node[:cumulus][:bond][$NAME]` | Configuration values for bond $NAME.  This will be the base for the following attributes. | Hash | `nil`[m
[31m-`[:slaves]` | Bond members (*required*). | Array | `required`[m
[31m-`[:ipv4]` | IPv4 address(s) to assign to the bond. | String or Array | `nil`[m
[31m-`[:ipv6]` | IPv6 address(s) to assign to the bond. | String or Array | `nil`[m
[31m-`[:alias]` | Interface alias (description). | String | `nil`[m
[31m-`[:mtu]` | MTU to configure for the interface. | Integer | `nil`[m
[31m-`[:post_up]` | Post-up command(s) to run | String or Array | `nil`[m
[31m-`[:pre_down]` | Pre-down command(s) to run | String or Array | `nil`[m
[31m-`[:addr_method]` | Address assignment method, `dhcp` or `loopback`. | String | `nil`[m
[31m-`[:virtual_mac]` | VRR virtual MAC (*needs to be fixed in cumulus cookbook*). | String | `nil`[m
[31m-`[:virtual_ip]` | VRR virtual IP (*needs to be fixed in cumulus cookbook*). | String | `nil`[m
[31m-`[:vids]` | Array of VLANs to be configured for a VLAN aware trunk interface. | Array | `nil`[m
[31m-`[:pvid]` | Native VLAN for a VLAN aware trunk interface. | Integer | `nil`[m
[31m-`[:miimon]` | MII link monitoring interval. | Integer | `100`[m
[31m-`[:min_links]` | Minimum number of slave links for the bond to be considered up. | Integer | `1`[m
[31m-`[:mode]` | Bonding mode. | String | `802.3ad`[m
[31m-`[:xmit_hash_policy]` | TX hashing policy. | String | `layer3+4`[m
[31m-`[:lacp_rate]` | LACP bond rate. | Integer | `1`[m
[31m-`[:lacp_bypass_allow]` | Enable LACP bypass. Set to `1` to enable (*needs to be boolean*). | Integer | `nil`[m
[31m-`[:lacp_bypass_period]` | LACP bypass period. | Integer | `nil`[m
[31m-`[:lacp_bypass_priority]` | String-in-array (*needs to be string*) of interfaces and priorities for LACP bypass priority mode. | Array | `nil`[m
[31m-`[:lacp_bypass_all_active]` | Enable all-active mode for LACP bypass. Set to `1` to enable (*needs to be boolean*). | Integer | `nil`[m
[31m-`[:mstpctl_portnetwork]` | Enable bridge assurance on a VLAN aware trunk. | Boolean | `nil`[m
[31m-`[:mstpctl_portadminedge]` | Enables admin edge port. | Boolean | `nil`[m
[31m-`[:mstpctl_bpduguard]` | Enable BPDU guard on a VLAN aware trunk. | Boolean | `nil`[m
[31m-`[:clag_id]` | Identifier for a CLAG bond. The ID must be the same on both CLAG peers. | Integer | `nil`[m
[32m+[m[32m`node['cumulus']['bond']` | A hash of bonds. Keys are the bond name, values are a hash with configuration for the bond. | Hash | `{}`[m
[32m+[m[32m`node['cumulus']['bond'][$NAME]` | Configuration values for bond $NAME.  This will be the base for the following attributes. | Hash | `nil`[m
[32m+[m[32m`['slaves']` | Bond members (*required*). | Array | `required`[m
[32m+[m[32m`['ipv4']` | IPv4 address(s) to assign to the bond. | String or Array | `nil`[m
[32m+[m[32m`['ipv6']` | IPv6 address(s) to assign to the bond. | String or Array | `nil`[m
[32m+[m[32m`['alias']` | Interface alias (description). | String | `nil`[m
[32m+[m[32m`['mtu']` | MTU to configure for the interface. | Integer | `nil`[m
[32m+[m[32m`['post_up']` | Post-up command(s) to run | String or Array | `nil`[m
[32m+[m[32m`['pre_down']` | Pre-down command(s) to run | String or Array | `nil`[m
[32m+[m[32m`['addr_method']` | Address assignment method, `dhcp` or `loopback`. | String | `nil`[m
[32m+[m[32m`['virtual_mac']` | VRR virtual MAC (*needs to be fixed in cumulus cookbook*). | String | `nil`[m
[32m+[m[32m`['virtual_ip']` | VRR virtual IP (*needs to be fixed in cumulus cookbook*). | String | `nil`[m
[32m+[m[32m`['vids']` | Array of VLANs to be configured for a VLAN aware trunk interface. | Array | `nil`[m
[32m+[m[32m`['pvid']` | Native VLAN for a VLAN aware trunk interface. | Integer | `nil`[m
[32m+[m[32m`['miimon']` | MII link monitoring interval. | Integer | `100`[m
[32m+[m[32m`['min_links']` | Minimum number of slave links for the bond to be considered up. | Integer | `1`[m
[32m+[m[32m`['mode']` | Bonding mode. | String | `802.3ad`[m
[32m+[m[32m`['xmit_hash_policy']` | TX hashing policy. | String | `layer3+4`[m
[32m+[m[32m`['lacp_rate']` | LACP bond rate. | Integer | `1`[m
[32m+[m[32m`['lacp_bypass_allow']` | Enable LACP bypass. Set to `1` to enable (*needs to be boolean*). | Integer | `nil`[m
[32m+[m[32m`['lacp_bypass_period']` | LACP bypass period. | Integer | `nil`[m
[32m+[m[32m`['lacp_bypass_priority']` | String-in-array (*needs to be string*) of interfaces and priorities for LACP bypass priority mode. | Array | `nil`[m
[32m+[m[32m`['lacp_bypass_all_active']` | Enable all-active mode for LACP bypass. Set to `1` to enable (*needs to be boolean*). | Integer | `nil`[m
[32m+[m[32m`['mstpctl_portnetwork']` | Enable bridge assurance on a VLAN aware trunk. | Boolean | `nil`[m
[32m+[m[32m`['mstpctl_portadminedge']` | Enables admin edge port. | Boolean | `nil`[m
[32m+[m[32m`['mstpctl_bpduguard']` | Enable BPDU guard on a VLAN aware trunk. | Boolean | `nil`[m
[32m+[m[32m`['clag_id']` | Identifier for a CLAG bond. The ID must be the same on both CLAG peers. | Integer | `nil`[m
 [m
 #### Ports[m
 [m
 Attribute        | Description |Type | Default[m
 -----------------|-------------|-----|--------[m
[31m-`node[:cumulus][:restart_switchd]` | Restart switchd when port changes are made. | Boolean | `false`[m
[31m-`node[:cumulus][:ports]['10g']` | Array of ports to be configured for 10GbE. | Array | `[]`[m
[31m-`node[:cumulus][:ports]['40g']` | Array of ports to be configured for 40GbE. | Array | `[]`[m
[31m-`node[:cumulus][:ports]['40g_div_4']` | Array of ports to be configured for 40GbE split to 4 x 10GbE. | Array | `[]`[m
[31m-`node[:cumulus][:ports]['4_by_10g']` | Array of ports to be configured for 10GbE to be aggregated into 1 x 40GbE. | Array | `[]`[m
[32m+[m[32m`node['cumulus']['restart_switchd']` | Restart switchd when port changes are made. | Boolean | `false`[m
[32m+[m[32m`node['cumulus']['ports']['10g']` | Array of ports to be configured for 10GbE. | Array | `[]`[m
[32m+[m[32m`node['cumulus']['ports']['40g']` | Array of ports to be configured for 40GbE. | Array | `[]`[m
[32m+[m[32m`node['cumulus']['ports']['40g_div_4']` | Array of ports to be configured for 40GbE split to 4 x 10GbE. | Array | `[]`[m
[32m+[m[32m`node['cumulus']['ports']['4_by_10g']` | Array of ports to be configured for 10GbE to be aggregated into 1 x 40GbE. | Array | `[]`[m
 [m
 cumulus-switch::mgmt_vrf[m
 ---[m
 [m
 Attribute        | Description |Type | Default[m
 -----------------|-------------|-----|--------[m
[31m-`node[:cumulus][:mgmt_vrf][:enabled]` | Enables or disables management VRF ([documentation](http://docs.cumulusnetworks.com/display/DOCS/Management+VRF)).  Note: this is `nil` by default, which causes no actions to be taken.  `true` will install and configure the management vrf. `false` will remove the package and disable the management vrf. | Boolean | `nil`[m
[31m-`node[:cumulus][:mgmt_vrf][:restart_quagga]` | Restart Quagga if management VRF status changes. | Boolean | `nil`[m
[32m+[m[32m`node['cumulus']['mgmt_vrf']['enabled']` | Enables or disables management VRF ([documentation](http://docs.cumulusnetworks.com/display/DOCS/Management+VRF)).  Note: this is `nil` by default, which causes no actions to be taken.  `true` will install and configure the management vrf. `false` will remove the package and disable the management vrf. | Boolean | `nil`[m
[32m+[m[32m`node['cumulus']['mgmt_vrf']['restart_quagga']` | Restart Quagga if management VRF status changes. | Boolean | `nil`[m
 [m
 Usage[m
 =====[m
[1;33mdiff --git i/test/cookbooks/cumulus-switch-test/recipes/bonds.rb w/test/cookbooks/cumulus-switch-test/recipes/bonds.rb[m
[1;33mindex 59c0989..36d09cf 100644[m
[1;33m--- i/test/cookbooks/cumulus-switch-test/recipes/bonds.rb[m
[1;33m+++ w/test/cookbooks/cumulus-switch-test/recipes/bonds.rb[m
[1;35m@@ -4,39 +4,39 @@[m
 #[m
 node.set['cumulus']['bond']['bond0']['slaves'] = ['swp1-2', 'swp4'][m
 [m
[31m-node.set[:cumulus][:bond]['bond1']['slaves'] = ['swp5-6'][m
[31m-node.set[:cumulus][:bond]['bond1']['ipv4'] = ['10.0.0.1/24', '192.168.1.0/16'][m
[31m-node.set[:cumulus][:bond]['bond1']['ipv6'] = ['2001:db8:abcd::/48'][m
[31m-node.set[:cumulus][:bond]['bond1']['clag_id'] = 1[m
[31m-node.set[:cumulus][:bond]['bond1']['lacp_bypass_allow'] = 1[m
[31m-node.set[:cumulus][:bond]['bond1']['lacp_bypass_period'] = 30[m
[31m-node.set[:cumulus][:bond]['bond1']['lacp_bypass_all_active'] = 1[m
[31m-node.set[:cumulus][:bond]['bond1']['virtual_ip'] = '192.168.20.1'[m
[31m-node.set[:cumulus][:bond]['bond1']['virtual_mac'] = '11:22:33:44:55:FF'[m
[31m-node.set[:cumulus][:bond]['bond1']['mstpctl_portnetwork'] = true[m
[31m-node.set[:cumulus][:bond]['bond1']['mstpctl_portadminedge'] = true[m
[31m-node.set[:cumulus][:bond]['bond1']['mstpctl_bpduguard'] = true[m
[31m-node.set[:cumulus][:bond]['bond1']['alias'] = 'bond number 1'[m
[31m-node.set[:cumulus][:bond]['bond1']['addr_method'] = 'static'[m
[31m-node.set[:cumulus][:bond]['bond1']['min_links'] = 2[m
[31m-node.set[:cumulus][:bond]['bond1']['mode'] = 'balance-alb'[m
[31m-node.set[:cumulus][:bond]['bond1']['miimon'] = 99[m
[31m-node.set[:cumulus][:bond]['bond1']['xmit_hash_policy'] = 'layer2'[m
[31m-node.set[:cumulus][:bond]['bond1']['lacp_rate'] = 9[m
[31m-node.set[:cumulus][:bond]['bond1']['mtu'] = 9000[m
[31m-node.set[:cumulus][:bond]['bond1']['clag_id'] = 1[m
[31m-node.set[:cumulus][:bond]['bond1']['vids'] = ['1-4094'][m
[31m-node.set[:cumulus][:bond]['bond1']['pvid'] = 1[m
[31m-node.set[:cumulus][:bond]['bond1']['post_up'] = [[m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['slaves'] = ['swp5-6'][m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['ipv4'] = ['10.0.0.1/24', '192.168.1.0/16'][m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['ipv6'] = ['2001:db8:abcd::/48'][m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['clag_id'] = 1[m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['lacp_bypass_allow'] = 1[m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['lacp_bypass_period'] = 30[m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['lacp_bypass_all_active'] = 1[m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['virtual_ip'] = '192.168.20.1'[m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['virtual_mac'] = '11:22:33:44:55:FF'[m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['mstpctl_portnetwork'] = true[m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['mstpctl_portadminedge'] = true[m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['mstpctl_bpduguard'] = true[m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['alias'] = 'bond number 1'[m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['addr_method'] = 'static'[m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['min_links'] = 2[m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['mode'] = 'balance-alb'[m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['miimon'] = 99[m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['xmit_hash_policy'] = 'layer2'[m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['lacp_rate'] = 9[m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['mtu'] = 9000[m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['clag_id'] = 1[m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['vids'] = ['1-4094'][m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['pvid'] = 1[m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['post_up'] = [[m
   "ip route add 10.0.0.0/8 via 192.168.200.2",[m
   "ip route add 172.16.0.0/12 via 192.168.200.2"[m
 ][m
[31m-node.set[:cumulus][:bond]['bond1']['pre_down'] = [[m
[32m+[m[32mnode.set['cumulus']['bond']['bond1']['pre_down'] = [[m
   "ip route del 10.0.0.0/8 via 192.168.200.2",[m
   "ip route del 172.16.0.0/12 via 192.168.200.2"[m
 ][m
 [m
[31m-node.set[:cumulus][:bond]['bond2']['slaves'] = ['swp7', 'swp8'][m
[31m-node.set[:cumulus][:bond]['bond2']['virtual_ip'] = '11:22:33:44:55:FF 192.168.20.1'[m
[31m-node.set[:cumulus][:bond]['bond2']['lacp_bypass_allow'] = 1[m
[31m-node.set[:cumulus][:bond]['bond2']['lacp_bypass_priority'] = ['swp7=10 swp8=5'][m
[32m+[m[32mnode.set['cumulus']['bond']['bond2']['slaves'] = ['swp7', 'swp8'][m
[32m+[m[32mnode.set['cumulus']['bond']['bond2']['virtual_ip'] = '11:22:33:44:55:FF 192.168.20.1'[m
[32m+[m[32mnode.set['cumulus']['bond']['bond2']['lacp_bypass_allow'] = 1[m
[32m+[m[32mnode.set['cumulus']['bond']['bond2']['lacp_bypass_priority'] = ['swp7=10 swp8=5'][m
[1;33mdiff --git i/test/cookbooks/cumulus-switch-test/recipes/bridges.rb w/test/cookbooks/cumulus-switch-test/recipes/bridges.rb[m
[1;33mindex adb6bf7..f0ed148 100644[m
[1;33m--- i/test/cookbooks/cumulus-switch-test/recipes/bridges.rb[m
[1;33m+++ w/test/cookbooks/cumulus-switch-test/recipes/bridges.rb[m
[1;35m@@ -3,39 +3,39 @@[m
 # Recipe:: bridges[m
 #[m
 [m
[31m-node.set[:cumulus][:bridge]['br0']['ports'] = ['swp9', 'swp10-11', 'swp12'][m
[31m-node.set[:cumulus][:bridge]['br0']['addr_method'] = 'dhcp'[m
[32m+[m[32mnode.set['cumulus']['bridge']['br0']['ports'] = ['swp9', 'swp10-11', 'swp12'][m
[32m+[m[32mnode.set['cumulus']['bridge']['br0']['addr_method'] = 'dhcp'[m
 [m
[31m-node.set[:cumulus][:bridge]['br1']['ports'] = ['swp13-14'][m
[31m-node.set[:cumulus][:bridge]['br1']['ipv4'] = ['10.0.0.1/24', '192.168.1.0/16'][m
[31m-node.set[:cumulus][:bridge]['br1']['ipv6'] = ['2001:db8:abcd::/48'][m
[31m-node.set[:cumulus][:bridge]['br1']['virtual_ip'] = '192.168.100.1'[m
[31m-node.set[:cumulus][:bridge]['br1']['virtual_mac'] = '11:22:33:44:55:FF'[m
[31m-node.set[:cumulus][:bridge]['br1']['stp'] = false[m
[31m-node.set[:cumulus][:bridge]['br1']['mtu'] = 9000[m
[31m-node.set[:cumulus][:bridge]['br1']['mstpctl_treeprio'] = 4096[m
[31m-node.set[:cumulus][:bridge]['br1']['alias'] = 'classic bridge number 1'[m
[32m+[m[32mnode.set['cumulus']['bridge']['br1']['ports'] = ['swp13-14'][m
[32m+[m[32mnode.set['cumulus']['bridge']['br1']['ipv4'] = ['10.0.0.1/24', '192.168.1.0/16'][m
[32m+[m[32mnode.set['cumulus']['bridge']['br1']['ipv6'] = ['2001:db8:abcd::/48'][m
[32m+[m[32mnode.set['cumulus']['bridge']['br1']['virtual_ip'] = '192.168.100.1'[m
[32m+[m[32mnode.set['cumulus']['bridge']['br1']['virtual_mac'] = '11:22:33:44:55:FF'[m
[32m+[m[32mnode.set['cumulus']['bridge']['br1']['stp'] = false[m
[32m+[m[32mnode.set['cumulus']['bridge']['br1']['mtu'] = 9000[m
[32m+[m[32mnode.set['cumulus']['bridge']['br1']['mstpctl_treeprio'] = 4096[m
[32m+[m[32mnode.set['cumulus']['bridge']['br1']['alias'] = 'classic bridge number 1'[m
 [m
 # New bridge driver all defaults[m
[31m-node.set[:cumulus][:bridge]['bridge2']['ports'] = ['swp15-16'][m
[31m-node.set[:cumulus][:bridge]['bridge2']['vlan_aware'] = true[m
[32m+[m[32mnode.set['cumulus']['bridge']['bridge2']['ports'] = ['swp15-16'][m
[32m+[m[32mnode.set['cumulus']['bridge']['bridge2']['vlan_aware'] = true[m
 [m
 # New bridge driver over-ride[m
[31m-node.set[:cumulus][:bridge]['bridge3']['ports'] = ['swp17-18'][m
[31m-node.set[:cumulus][:bridge]['bridge3']['vlan_aware'] = true[m
[31m-node.set[:cumulus][:bridge]['bridge3']['vids'] = ['1-4094'][m
[31m-node.set[:cumulus][:bridge]['bridge3']['pvid'] = 1[m
[31m-node.set[:cumulus][:bridge]['bridge3']['ipv4'] = ['10.0.100.1/24', '192.168.100.0/16'][m
[31m-node.set[:cumulus][:bridge]['bridge3']['ipv6'] = ['2001:db8:1234::/48'][m
[31m-node.set[:cumulus][:bridge]['bridge3']['alias_name'] = 'new bridge number 3'[m
[31m-node.set[:cumulus][:bridge]['bridge3']['mtu'] = 9000[m
[31m-node.set[:cumulus][:bridge]['bridge3']['stp'] = false[m
[31m-node.set[:cumulus][:bridge]['bridge3']['mstpctl_treeprio'] = 4096[m
[31m-node.set[:cumulus][:bridge]['bridge3']['post_up'] = [[m
[32m+[m[32mnode.set['cumulus']['bridge']['bridge3']['ports'] = ['swp17-18'][m
[32m+[m[32mnode.set['cumulus']['bridge']['bridge3']['vlan_aware'] = true[m
[32m+[m[32mnode.set['cumulus']['bridge']['bridge3']['vids'] = ['1-4094'][m
[32m+[m[32mnode.set['cumulus']['bridge']['bridge3']['pvid'] = 1[m
[32m+[m[32mnode.set['cumulus']['bridge']['bridge3']['ipv4'] = ['10.0.100.1/24', '192.168.100.0/16'][m
[32m+[m[32mnode.set['cumulus']['bridge']['bridge3']['ipv6'] = ['2001:db8:1234::/48'][m
[32m+[m[32mnode.set['cumulus']['bridge']['bridge3']['alias_name'] = 'new bridge number 3'[m
[32m+[m[32mnode.set['cumulus']['bridge']['bridge3']['mtu'] = 9000[m
[32m+[m[32mnode.set['cumulus']['bridge']['bridge3']['stp'] = false[m
[32m+[m[32mnode.set['cumulus']['bridge']['bridge3']['mstpctl_treeprio'] = 4096[m
[32m+[m[32mnode.set['cumulus']['bridge']['bridge3']['post_up'] = [[m
   "ip route add 10.0.0.0/8 via 192.168.200.2",[m
   "ip route add 172.16.0.0/12 via 192.168.200.2"[m
 ][m
[31m-node.set[:cumulus][:bridge]['bridge3']['pre_down'] = [[m
[32m+[m[32mnode.set['cumulus']['bridge']['bridge3']['pre_down'] = [[m
   "ip route del 10.0.0.0/8 via 192.168.200.2",[m
   "ip route del 172.16.0.0/12 via 192.168.200.2"[m
 ][m
[1;33mdiff --git i/test/cookbooks/cumulus-switch-test/recipes/interfaces.rb w/test/cookbooks/cumulus-switch-test/recipes/interfaces.rb[m
[1;33mindex b445ef9..62a6a34 100644[m
[1;33m--- i/test/cookbooks/cumulus-switch-test/recipes/interfaces.rb[m
[1;33m+++ w/test/cookbooks/cumulus-switch-test/recipes/interfaces.rb[m
[1;35m@@ -4,41 +4,41 @@[m
 #[m
 [m
 # With all defaults[m
[31m-node.set[:cumulus][:interface]['swp1'][m
[32m+[m[32mnode.set['cumulus']['interface']['swp1'][m
 [m
 # Over-ride defaults[m
[31m-node.set[:cumulus][:interface]['swp2']['ipv4'] = ['192.168.200.1'][m
[31m-node.set[:cumulus][:interface]['swp2']['ipv6'] = ['2001:db8:5678::'][m
[31m-node.set[:cumulus][:interface]['swp2']['addr_method'] = 'static'[m
[31m-node.set[:cumulus][:interface]['swp2']['speed'] = '1000'[m
[31m-node.set[:cumulus][:interface]['swp2']['mtu'] = 9000[m
[31m-node.set[:cumulus][:interface]['swp2']['vids'] = ['1-4094'][m
[31m-node.set[:cumulus][:interface]['swp2']['pvid'] = 1[m
[31m-node.set[:cumulus][:interface]['swp2']['alias'] = 'interface swp2'[m
[31m-node.set[:cumulus][:interface]['swp2']['virtual_mac'] = '11:22:33:44:55:66'[m
[31m-node.set[:cumulus][:interface]['swp2']['virtual_ip'] = '192.168.10.1'[m
[31m-node.set[:cumulus][:interface]['swp2']['mstpctl_portnetwork'] = true[m
[31m-node.set[:cumulus][:interface]['swp2']['mstpctl_portadminedge'] = true[m
[31m-node.set[:cumulus][:interface]['swp2']['mstpctl_bpduguard'] = true[m
[31m-node.set[:cumulus][:interface]['swp2']['post_up'] = [[m
[32m+[m[32mnode.set['cumulus']['interface']['swp2']['ipv4'] = ['192.168.200.1'][m
[32m+[m[32mnode.set['cumulus']['interface']['swp2']['ipv6'] = ['2001:db8:5678::'][m
[32m+[m[32mnode.set['cumulus']['interface']['swp2']['addr_method'] = 'static'[m
[32m+[m[32mnode.set['cumulus']['interface']['swp2']['speed'] = '1000'[m
[32m+[m[32mnode.set['cumulus']['interface']['swp2']['mtu'] = 9000[m
[32m+[m[32mnode.set['cumulus']['interface']['swp2']['vids'] = ['1-4094'][m
[32m+[m[32mnode.set['cumulus']['interface']['swp2']['pvid'] = 1[m
[32m+[m[32mnode.set['cumulus']['interface']['swp2']['alias'] = 'interface swp2'[m
[32m+[m[32mnode.set['cumulus']['interface']['swp2']['virtual_mac'] = '11:22:33:44:55:66'[m
[32m+[m[32mnode.set['cumulus']['interface']['swp2']['virtual_ip'] = '192.168.10.1'[m
[32m+[m[32mnode.set['cumulus']['interface']['swp2']['mstpctl_portnetwork'] = true[m
[32m+[m[32mnode.set['cumulus']['interface']['swp2']['mstpctl_portadminedge'] = true[m
[32m+[m[32mnode.set['cumulus']['interface']['swp2']['mstpctl_bpduguard'] = true[m
[32m+[m[32mnode.set['cumulus']['interface']['swp2']['post_up'] = [[m
   "ip route add 10.0.0.0/8 via 192.168.200.2",[m
   "ip route add 172.16.0.0/12 via 192.168.200.2"[m
 ][m
[31m-node.set[:cumulus][:interface]['swp2']['pre_down'] = [[m
[32m+[m[32mnode.set['cumulus']['interface']['swp2']['pre_down'] = [[m
   "ip route del 10.0.0.0/8 via 192.168.200.2",[m
   "ip route del 172.16.0.0/12 via 192.168.200.2"[m
 ][m
 [m
 # Test post_up and pre_down as String instead of Array[m
[31m-node.set[:cumulus][:interface]['swp3']['post_up'] = "ip route add 192.168.0.0/16 via 192.168.200.2"[m
[31m-node.set[:cumulus][:interface]['swp3']['pre_down'] = "ip route del 192.168.0.0/16 via 192.168.200.2"[m
[32m+[m[32mnode.set['cumulus']['interface']['swp3']['post_up'] = "ip route add 192.168.0.0/16 via 192.168.200.2"[m
[32m+[m[32mnode.set['cumulus']['interface']['swp3']['pre_down'] = "ip route del 192.168.0.0/16 via 192.168.200.2"[m
 [m
 # CLAGD[m
[31m-node.set[:cumulus][:interface]['swp4']['clagd_enable'] = true[m
[31m-node.set[:cumulus][:interface]['swp4']['clagd_priority'] = 1[m
[31m-node.set[:cumulus][:interface]['swp4']['clagd_peer_ip'] = '10.1.2.3'[m
[31m-node.set[:cumulus][:interface]['swp4']['clagd_sys_mac'] = 'aa:bb:cc:dd:ee:ff'[m
[31m-node.set[:cumulus][:interface]['swp4']['clagd_args'] = '--backupPort 5400'[m
[32m+[m[32mnode.set['cumulus']['interface']['swp4']['clagd_enable'] = true[m
[32m+[m[32mnode.set['cumulus']['interface']['swp4']['clagd_priority'] = 1[m
[32m+[m[32mnode.set['cumulus']['interface']['swp4']['clagd_peer_ip'] = '10.1.2.3'[m
[32m+[m[32mnode.set['cumulus']['interface']['swp4']['clagd_sys_mac'] = 'aa:bb:cc:dd:ee:ff'[m
[32m+[m[32mnode.set['cumulus']['interface']['swp4']['clagd_args'] = '--backupPort 5400'[m
 [m
 # Interface range[m
 node.set['cumulus']['interface_range']['swp[5-7]']['mtu'] = 9000[m
[1;33mdiff --git i/test/cookbooks/cumulus-switch-test/recipes/mgmt_vrf.rb w/test/cookbooks/cumulus-switch-test/recipes/mgmt_vrf.rb[m
[1;33mindex aca40f0..4120b9e 100644[m
[1;33m--- i/test/cookbooks/cumulus-switch-test/recipes/mgmt_vrf.rb[m
[1;33m+++ w/test/cookbooks/cumulus-switch-test/recipes/mgmt_vrf.rb[m
[1;35m@@ -2,5 +2,5 @@[m
 # Cookbook Name:: cumulus-switch-test[m
 # Recipe:: mgmt_vrf[m
 #[m
[31m-node.set[:cumulus][:mgmt_vrf][:enabled] = true[m
[31m-node.set[:cumulus][:mgmt_vrf][:restart_quagga] = true[m
[32m+[m[32mnode.set['cumulus']['mgmt_vrf']['enabled'] = true[m
[32m+[m[32mnode.set['cumulus']['mgmt_vrf']['restart_quagga'] = true[m
[1;33mdiff --git i/test/cookbooks/cumulus-switch-test/recipes/ports.rb w/test/cookbooks/cumulus-switch-test/recipes/ports.rb[m
[1;33mindex 06efd67..8d87fcd 100644[m
[1;33m--- i/test/cookbooks/cumulus-switch-test/recipes/ports.rb[m
[1;33m+++ w/test/cookbooks/cumulus-switch-test/recipes/ports.rb[m
[1;35m@@ -2,7 +2,7 @@[m
 # Cookbook Name:: cumulus-switch-test[m
 # Recipe:: ports[m
 #[m
[31m-node.set[:cumulus][:ports]['10g'] = ['swp1'][m
[31m-node.set[:cumulus][:ports]['40g'] = ['swp2-3'][m
[31m-node.set[:cumulus][:ports]['40g_div_4'] = ['swp4', 'swp5'][m
[31m-node.set[:cumulus][:ports]['4_by_10g'] = ['swp6', 'swp7-8'][m
[32m+[m[32mnode.set['cumulus']['ports']['10g'] = ['swp1'][m
[32m+[m[32mnode.set['cumulus']['ports']['40g'] = ['swp2-3'][m
[32m+[m[32mnode.set['cumulus']['ports']['40g_div_4'] = ['swp4', 'swp5'][m
[32m+[m[32mnode.set['cumulus']['ports']['4_by_10g'] = ['swp6', 'swp7-8'][m
