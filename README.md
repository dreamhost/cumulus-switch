Description
===========

This cookbook provides an interface via attributes to the [official Cumulus cookbook](https://github.com/CumulusNetworks/cumulus-linux-chef-modules)'s providers.

What can this configure?
* Interfaces
* Bridges
* Bonds
* Port HW
* Management VRF

The idea here is to be able to have a flexible interface that can be used for configuring Cumulus gear in any environment.  It works especially well when paired with the [quagga](https://github.com/floored1585/quagga-cookbook) cookbook, allowing complete automation and templating for routing, switching, and management on a Cumulus device.

Requirements
============

Tested on:
* Cumulus Linux 2.5.3

Attributes
==========

NOTE! Where you see "String or Array" for type, a String may be used _only_ for single values.  Use 
an Array of Strings for multiple values.

### Interfaces & interface ranges

Attribute        | Description |Type | Default
-----------------|-------------|-----|--------
`node[:cumulus][:interface]` | A hash of interfaces. Keys are the interface name, values are a hash with optional configuration. | Hash | `{}`
`node[:cumulus][:interface][$NAME]` | Configuration values for interface $NAME.  This will be the base for the following attributes. | Hash | `nil`
`[:ipv4]` | IPv4 address(s) to assign to the interface. | String or Array | `nil`
`[:ipv6]` | IPv6 address(s) to assign to the interface. | String or Array | `nil`
`[:speed]` | Speed to configure for the interface. | String | `nil`
`[:mtu]` | MTU to configure for the interface. | Integer | `nil`
`[:post_up]` | Post-up command(s) to run | String or Array | `nil`
`[:addr_method]` | Address assignment method, `dhcp` or `loopback`. | String | `nil`
`[:mstpctl_portnetwork]` | Enable bridge assurance on a VLAN aware trunk. | Boolean | `nil`
`[:mstpctl_portadminedge]` | Enables admin edge port. | Boolean | `nil`
`[:mstpctl_bpduguard]` | Enable BPDU guard on a VLAN aware trunk. | Boolean | `nil`
`[:clagd_enable]` | Enable CLAGD on the interface ([documentation](http://docs.cumulusnetworks.com/display/DOCS/Multi-Chassis+Link+Aggregation+-+MLAG)). | Boolean | `nil`
`[:clagd_peer_ip]` | Address of the CLAG peer switch | String | `nil`
`[:clagd_priority]` | CLAG priority for this switch | Integer | `nil`
`[:clagd_sys_mac]` | CLAG system MAC. The MAC must be identical on both of the CLAG peers. | String | `nil`

Note!  You can use all of the above attributes on `node[:cumulus][:interface_range][$NAME]` as well.  Use a a String in a format like `swp[1-24].100` or `swp[2-5]` for $NAME.

### Bridges

Attribute        | Description |Type | Default
-----------------|-------------|-----|--------
`node[:cumulus][:bridge]` | A hash of bridges. Keys are the bridge name, values are a hash with configuration for the bridge. | Hash | `{}`
`node[:cumulus][:bridge][$NAME]` | Configuration values for bridge $NAME.  This will be the base for the following attributes. | Hash | `nil`
`[:ports]` | Interfaces to place in the bridge (*required*). | Array | `required`
`[:ipv4]` | IPv4 address(s) to assign to the bridge. | Array | `nil`
`[:ipv6]` | IPv6 address(s) to assign to the bridge. | Array | `nil`
`[:virtual_ip]` | VRR virtual IP ([documentation](http://docs.cumulusnetworks.com/display/DOCS/Virtual+Router+Redundancy+-+VRR)). | String | `nil`
`[:virtual_mac]` | VRR virtual MAC address ([documentation](http://docs.cumulusnetworks.com/display/DOCS/Virtual+Router+Redundancy+-+VRR)). | String | `nil`
`[:stp]` | Enable STP on the bridge. | Boolean | `true`

### Bonds

Attribute        | Description |Type | Default
-----------------|-------------|-----|--------
`node[:cumulus][:bond]` | A hash of bonds. Keys are the bond name, values are a hash with configuration for the bond. | Hash | `{}`
`node[:cumulus][:bond][$NAME]` | Configuration values for bond $NAME.  This will be the base for the following attributes. | Hash | `nil`
`[:ipv4]` | IPv4 address(s) to assign to the bond. | String or Array | `nil`
`[:ipv6]` | IPv6 address(s) to assign to the bond. | String or Array | `nil`
`[:slaves]` | Bond members (*required*). | Array | `required`
`[:mstpctl_portnetwork]` | Enable bridge assurance on a VLAN aware trunk. | Boolean | `nil`
`[:mstpctl_portadminedge]` | Enables admin edge port. | Boolean | `nil`
`[:mstpctl_bpduguard]` | Enable BPDU guard on a VLAN aware trunk. | Boolean | `nil`
`[:clag_id]` | Identifier for a CLAG bond. The ID must be the same on both CLAG peers. | Integer | `nil`

### Ports

Attribute        | Description |Type | Default
-----------------|-------------|-----|--------
`node[:cumulus][:ports]['10g']` | Array of ports to be configured for 10GbE. | Array | `[]`
`node[:cumulus][:ports]['40g']` | Array of ports to be configured for 40GbE. | Array | `[]`
`node[:cumulus][:ports]['40g_div_4']` | Array of ports to be configured for 40GbE split to 4 x 10GbE. | Array | `[]`
`node[:cumulus][:ports]['4_by_10g']` | Array of ports to be configured for 10GbE to be aggregated into 1 x 40GbE. | Array | `[]`

### Management VRF

Attribute        | Description |Type | Default
-----------------|-------------|-----|--------
`node[:cumulus][:mgmt_vrf][:enabled]` | Enables or disables management VRF ([documentation](http://docs.cumulusnetworks.com/display/DOCS/Management+VRF)).  Note: this is `nil` by default, which causes no actions to be taken.  `true` will install and configure the management vrf. `false` will remove the package and disable the management vrf. | Boolean | `nil`
`node[:cumulus][:mgmt_vrf][:restart_quagga]` | Restart Quagga if management VRF status changes. | Boolean | `nil`

Usage
=====

Simply set the desired attributes (see Attributes section above) then call the proper recipe (cumulus-switch::base).

### Example

Coming soon, maybe

Contributing
============

Any form of contribution is welcome!  Feature requests, bug reports, pull requests, whatever!
If you add features, make sure there are tests for them, and if you change any code, make sure
the existing tests all pass _before_ creating a pull request.

Tests are run on a [Cumulus VX](https://cumulusnetworks.com/cumulus-vx) VM using serverspec.

Testing requirements:
* Vagrant
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
