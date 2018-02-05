Description
===========

This cookbook provides an interface via attributes to the [official Cumulus cookbook](https://github.com/CumulusNetworks/cumulus-linux-chef-modules)'s providers, and then some.

What can this configure?
* Interfaces
* Bridges
* Bonds
* Ports
* Management VRF

The idea here is to be able to have a flexible interface that can be used for configuring Cumulus gear in any environment.  It works especially well when paired with the [quagga](https://github.com/floored1585/quagga-cookbook) cookbook, allowing complete automation and templating for routing, switching, and management on a Cumulus device.

Requirements
============

Tested on:
* Cumulus Linux 2.5.3
* Cumulus Linux 3.3.2

Recipes
==========

### cumulus-switch::default

The default recipe does nothing.

### cumulus-switch::base

The base recipe enables configuration of:
* Interfaces
* Bridges
* Bonds
* Ports

### cumulus-switch::isc-dhcp-relay

The isc-dhcp-relay recipe enables configuration of a dhcp relay.  This is a temporary measure, and won't be here for long.

### cumulus-switch::mgmt-vrf

The mgmt-vrf recipe enables configuration of a Management VRF ([documentation](http://docs.cumulusnetworks.com/display/DOCS/Management+VRF))

### cumulus-switch::license

The license recipe installs a license. The value must be a URL where the license file is located.

Attributes
==========

NOTE! Where you see "String or Array" for type, a String may be used _only_ for single values.  Use 
an Array of Strings for multiple values.

NOTE! Tests for virtual_mac and virtual_ip are currently failing due to a bug in the [cumulus](https://github.com/CumulusNetworks/cumulus-linux-chef-modules) cookbook.  To use these attributes, place both in the virtual_ip attribute (`...['virtual_ip'] = 'AA:BB:CC:DD:EE:FF 10.0.0.1'`)

cumulus-switch::base
---

#### Interfaces & interface ranges

Attribute        | Description |Type | Default
-----------------|-------------|-----|--------
`node['cumulus']['interface']` | A hash of interfaces. Keys are the interface name, values are a hash with optional configuration. | Hash | `{}`
`node['cumulus']['interface'][$NAME]` | Configuration values for interface $NAME.  This will be the base for the following attributes. | Hash | `nil`
`['addr_method']` | Address assignment method, `dhcp` or `loopback`. | String | `nil`
`['alias']` | Interface alias (description). | String | `nil`
`['bridge_access']` | The vlan that the access port is a member of. | String | `nil`
`['clagd_args']` | Any additional arguments to be passed to the clagd deamon. | String | `nil`
`['clagd_backup_ip']` | CLAG Backup IP. | String | `nil`
`['clagd_enable']` | Enable CLAGD on the interface ([documentation](http://docs.cumulusnetworks.com/display/DOCS/Multi-Chassis+Link+Aggregation+-+MLAG)). | Boolean | `nil`
`['clagd_peer_ip']` | Address of the CLAG peer switch | String | `nil`
`['clagd_priority']` | CLAG priority for this switch | Integer | `nil`
`['clagd_sys_mac']` | CLAG system MAC. The MAC must be identical on both of the CLAG peers. | String | `nil`
`['clagd_vxlan_anycast_ip']` | This is the vxlan anycast IP to allow for mac table sharing. | String | `nil`
`['ipv4']` | IPv4 address(s) to assign to the interface. | String or Array | `nil`
`['ipv6']` | IPv6 address(s) to assign to the interface. | String or Array | `nil`
`['mstpctl_bpduguard']` | Enable BPDU guard on a VLAN aware trunk port. | Boolean | `nil`
`['mstpctl_portadminedge']` | Enables admin edge port. | Boolean | `nil`
`['mstpctl_portbpdufilter']` | Enable BPDU filter on a VLAN aware trunk port. | Boolean | `nil`
`['mstpctl_portnetwork']` | Enable bridge assurance on a VLAN aware trunk. | Boolean | `nil`
`['mtu']` | MTU to configure for the interface. | Integer | `nil`
`['post_up']` | Post-up command(s) to run | String or Array | `nil`
`['pre_down']` | Pre-down command(s) to run | String or Array | `nil`
`['pvid']` | Native VLAN for a VLAN aware trunk interface. | Integer | `nil`
`['speed']` | Speed to configure for the interface. | String | `nil`
`['vids']` | Array of VLANs to be configured for a VLAN aware trunk interface. | Array | `nil`
`['virtual_ip']` | VRR virtual IP. | String | `nil`
`['virtual_mac']` | VRR virtual MAC. | String | `nil`
`['vxlan_id']` | Vxlan id for the interface. | String | `nil`
`['vxlan_local_tunnelip']` | Ip address that is used for vxlan tunnel peering. | String | `nil`
`['vxrd_src_ip']` | This is the src IP for all LVN Vxlan. | String | `nil`
`['vxrd_svcnode_ip']` | This is the service node IP for all LVN Vxlan. | String | `nil`

Note!  You can use all of the above attributes on `node['cumulus']['interface_range'][$NAME]` as well.  Use a a String in a format like `swp[1-24].100` or `swp[2-5]` for $NAME.
Note!  To have any clagd configuration you must set clagd_enable to be evaluated as true.

#### Bridges

Attribute        | Description |Type | Default
-----------------|-------------|-----|--------
`node['cumulus']['bridge']` | A hash of bridges. Keys are the bridge name, values are a hash with configuration for the bridge. | Hash | `{}`
`node['cumulus']['bridge'][$NAME]` | Configuration values for bridge $NAME.  This will be the base for the following attributes. | Hash | `nil`
`['ports']` | Interfaces to place in the bridge (*required*). | Array | `required`
`['ipv4']` | IPv4 address(s) to assign to the bridge. | Array | `nil`
`['ipv6']` | IPv6 address(s) to assign to the bridge. | Array | `nil`
`['alias']` | Interface alias (description). | String | `nil`
`['addr_method']` | Address assignment method, `dhcp` or `loopback`. | String | `nil`
`['mtu']` | MTU to configure for the interface. | Integer | `nil`
`['post_up']` | Post-up command(s) to run | String or Array | `nil`
`['pre_down']` | Pre-down command(s) to run | String or Array | `nil`
`['vids']` | Array of VLANs to be configured for a VLAN aware trunk interface. | Array | `nil`
`['pvid']` | Native VLAN for a VLAN aware trunk interface. | Integer | `nil`
`['vlan_aware']` | Use the VLAN aware bridge driver. | Boolean | `false`
`['virtual_ip']` | VRR virtual IP ([documentation](http://docs.cumulusnetworks.com/display/DOCS/Virtual+Router+Redundancy+-+VRR)). | String | `nil`
`['virtual_mac']` | VRR virtual MAC address ([documentation](http://docs.cumulusnetworks.com/display/DOCS/Virtual+Router+Redundancy+-+VRR)). | String | `nil`
`['stp']` | Enable STP on the bridge. | Boolean | `true`
`['mstp_treeprio']` | Bridge root priority. Must be multiple of 4096. | Integer | `nil`

#### Bonds

Attribute        | Description |Type | Default
-----------------|-------------|-----|--------
`node['cumulus']['bond']` | A hash of bonds. Keys are the bond name, values are a hash with configuration for the bond. | Hash | `{}`
`node['cumulus']['bond'][$NAME]` | Configuration values for bond $NAME.  This will be the base for the following attributes. | Hash | `nil`
`['addr_method']` | Address assignment method, `dhcp` or `loopback`. | String | `nil`
`['alias']` | Interface alias (description). | String | `nil`
`['bridge_access']` | The vlan that the access port is a member of. | String | `nil`
`['clag_id']` | Identifier for a CLAG bond. The ID must be the same on both CLAG peers. | Integer | `nil`
`['ipv4']` | IPv4 address(s) to assign to the bond. | String or Array | `nil`
`['ipv6']` | IPv6 address(s) to assign to the bond. | String or Array | `nil`
`['lacp_bypass_allow']` | Enable LACP bypass. Set to `1` to enable (*needs to be boolean*). | Integer | `nil`
`['lacp_rate']` | LACP bond rate. | Integer | `1`
`['miimon']` | MII link monitoring interval. | Integer | `100`
`['min_links']` | Minimum number of slave links for the bond to be considered up. | Integer | `1`
`['mode']` | Bonding mode. | String | `802.3ad`
`['mstpctl_bpduguard']` | Enable BPDU guard on a VLAN aware trunk. | Boolean | `nil`
`['mstpctl_portadminedge']` | Enables admin edge port. | Boolean | `nil`
`['mstpctl_portnetwork']` | Enable bridge assurance on a VLAN aware trunk. | Boolean | `nil`
`['mtu']` | MTU to configure for the interface. | Integer | `nil`
`['post_up']` | Post-up command(s) to run | String or Array | `nil`
`['pre_down']` | Pre-down command(s) to run | String or Array | `nil`
`['pvid']` | Native VLAN for a VLAN aware trunk interface. | Integer | `nil`
`['slaves']` | Bond members (*required*). | Array | `required`
`['vids']` | Array of VLANs to be configured for a VLAN aware trunk interface. | Array | `nil`
`['virtual_ip']` | VRR virtual IP (*needs to be fixed in cumulus cookbook*). | String | `nil`
`['virtual_mac']` | VRR virtual MAC (*needs to be fixed in cumulus cookbook*). | String | `nil`
`['xmit_hash_policy']` | TX hashing policy. | String | `layer3+4`

#### Ports

Attribute        | Description |Type | Default
-----------------|-------------|-----|--------
`node['cumulus']['restart_switchd']` | Restart switchd when port changes are made. | Boolean | `false`
`node['cumulus']['ports']['10g']` | Array of ports to be configured for 10GbE. | Array | `[]`
`node['cumulus']['ports']['40g']` | Array of ports to be configured for 40GbE. | Array | `[]`
`node['cumulus']['ports']['40g_div_4']` | Array of ports to be configured for 40GbE split to 4 x 10GbE. | Array | `[]`
`node['cumulus']['ports']['4_by_10g']` | Array of ports to be configured for 10GbE to be aggregated into 1 x 40GbE. | Array | `[]`

cumulus-switch::mgmt_vrf
---

NOTE! With Cumulus Linux 3.x, this recipe can simply be included; no need to set any attributes.

Attribute        | Description |Type | Default
-----------------|-------------|-----|--------
`node['cumulus']['mgmt_vrf']['enabled']` | In Cumulus Linux 2.x, this enables or disables management VRF ([documentation](http://docs.cumulusnetworks.com/display/DOCS/Management+VRF)).  Note: this is `nil` by default, which causes no actions to be taken.  `true` will install and configure the management vrf. `false` will remove the package and disable the management vrf. | Boolean | `nil`
`node['cumulus']['mgmt_vrf']['restart_quagga']` | In Cumulus Linux 2.x, this restarts Quagga if management VRF status changes. | Boolean | `nil`

Usage
=====

Simply set the desired attributes (see Attributes section above) then call the applicable recipe.

### Example

Coming soon, maybe

Contributing
============

Any form of contribution is welcome!  Feature requests, bug reports, pull requests, whatever!
If you add features, make sure there are tests for them, and if you change any code, make sure
the existing tests all pass _before_ creating a pull request.

Tests are run on [Cumulus VX](https://cumulusnetworks.com/cumulus-vx) VMs using serverspec.

Testing requirements:
* Vagrant + cumulus-vagrant plugin (`vagrant plugin install vagrant-cumulus`)
* VirtualBox

To run the tests (after installing prerequisites):
* `bundle install`
* `rake rubocop`
* `foodcritic .`
* `rake test`

Author and License
===================

Copyright 2015, DreamHost

### License

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
