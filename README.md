cumulus-application-example Cookbook
=============
This cookbook effectively wraps the cumulus-linux-chef-modules cookbook's LWRPs, allowing configuration of a Cumulus switch using node attributes.

Requirements
------------
TODO: List your cookbook requirements. Be sure to include any requirements this cookbook has on platforms, libraries, other cookbooks, packages, operating systems, etc.

e.g.
#### packages
- `toaster` - cumulus-application-example needs toaster to brown your bagel.

Attributes
----------

Quick example.  This needs organizing...

node.default['dh_network']['bridge']['bridge-name']['ipv4'] = ['203.0.113.1/24']
node.default['dh_network']['bridge']['bridge-name']['ipv6'] = ['2001:DB8::1/64']
node.default['dh_network']['bridge']['bridge-name']['ports'] = ['swp1-24']
node.default['dh_network']['interface_range']['swp[1-24]']['speed'] = '10000'
node.default['dh_network']['interface_range']['swp[1-24]']['mtu'] = 9000
node.default['dh_network']['interface']['eth0'] = {}
node.default['dh_network']['interface']['swp1']['speed'] = '10000'
node.default['dh_network']['interface']['swp1']['mtu'] = 9000
node.default['dh_network']['ports']['10g'] = ['swp1-24']

TODO: List your cookbook attributes here.

e.g.
#### cumulus-application-example::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['cumulus-application-example']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### cumulus-application-example::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `cumulus-application-example` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[cumulus-application-example]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
