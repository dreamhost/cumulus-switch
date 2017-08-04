## 2.1.0 (TBD):

Features:
  - Cumulus Linux 3.x support (@floored1585)

Code Cleanup:
  - Style fixes (@floored1585)

## 0.1.6 (???):

Features:
  - add the following support in ::base to interface and interface-range:
    - alias
    - pre-down
    - virutal_mac
    - virtual_ip
    - vids
    - pvid
    - clagd_args
  - add the following support in ::base to bond:
    - addr_method
    - alias
    - mtu
    - miimon
    - min_links
    - mode
    - xmit_hash_policy
    - lacp_rate
    - lacp_bypass_period
    - lacp_bypass_priority
    - lacp_bypass_all_active
    - virtual_mac
    - vids
    - pvid
    - post_up
    - pre_down
  - add the following support in ::base to bridge:
    - mtu
    - alias
    - mstpctl_treeprio
    - post_up
    - pre_down
    - vids
    - pvid
    - vlan_aware
    - addr_method

Code Cleanup:
  - style fixes

## 0.1.5 (2015-11-10)

Features:

  - add Management VRF ([documentation](http://docs.cumulusnetworks.com/display/DOCS/Management+VRF)) support (@floored1585)
  - add STP option for bonds and interfaces (@nertwork)
  - add dhcp relay support (this will be moving out of here eventually) (@nertwork)
  - add clagd support for bonds (@nertwork)
