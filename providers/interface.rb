# Copyright (C) 2015 Cumulus Networks Inc.
# Copyright (C) 2016 DreamHost
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
def whyrun_supported?
  true
end

use_inline_resources

action :create do
  name = new_resource.name
  range = new_resource.range

  # If we have an interface range, look in the right place for the data
  if range
    data = node['cumulus']['interface_range'][range]
  else
    data = node['cumulus']['interface'][name]
  end

  addr_method = data['addr_method']
  alias_name = data['alias']
  bridge_access = data['bridge_access']
  clagd_enable = data['clagd_enable']
  ipv4 = data['ipv4'] || []
  ipv6 = data['ipv6'] || []
  mstpctl_bpduguard = data['mstpctl_bpduguard']
  mstpctl_portadminedge = data['mstpctl_portadminedge']
  mstpctl_portbpdufilter = data['mstpctl_portbpdufilter']
  mstpctl_portnetwork = data['mstpctl_portnetwork']
  mtu = data['mtu']
  post_up = data['post_up']
  pre_down = data['pre_down']
  pvid = data['pvid']
  speed = data['speed']
  vids = data['vids']
  virtual_ip = data['virtual_ip']
  virtual_mac = data['virtual_mac']
  vrf = data['vrf']
  vrf_table = data['vrf_table']
  vxlan_ageing = data['vxlan_ageing']
  vxlan_id = data['vxlan_id']
  vxlan_local_tunnelip = data['vxlan_local_tunnelip']
  vxrd_src_ip = data['vxrd_src_ip']
  vxrd_svcnode_ip = data['vxrd_svcnode_ip']

  location = new_resource.location

  address = ipv4 + ipv6

  config = {}

  # Insert optional parameters
  config['address'] = address unless address.nil? || address.empty?
  # If single address, don't use an array (for ifquery -o json equality test)
  config['address'] = address[0] if address.class == Array && address.count == 1
  config['address-virtual'] = [virtual_mac, virtual_ip].compact.join(' ') unless virtual_ip.nil? && virtual_mac.nil?
  config['alias'] = alias_name.to_s unless alias_name.nil?
  config['bridge-pvid'] = pvid.to_s unless pvid.nil?
  config['bridge-vids'] = vids unless vids.nil?
  config['bridge-access'] = bridge_access.to_s unless bridge_access.nil?
  config['mstpctl-bpduguard'] = Cumulus::Utils.bool_to_yn(mstpctl_bpduguard) unless mstpctl_bpduguard.nil?
  config['mstpctl-portadminedge'] = Cumulus::Utils.bool_to_yn(mstpctl_portadminedge) unless mstpctl_portadminedge.nil?
  config['mstpctl-portbpdufilter'] = Cumulus::Utils.bool_to_yn(mstpctl_portbpdufilter) unless mstpctl_portbpdufilter.nil?
  config['mstpctl-portnetwork'] = Cumulus::Utils.bool_to_yn(mstpctl_portnetwork) unless mstpctl_portnetwork.nil?
  config['mtu'] = mtu.to_s unless mtu.nil?
  config['post-up'] = post_up unless post_up.nil?
  config['pre-down'] = pre_down unless pre_down.nil?
  config['vrf'] = vrf.to_s unless vrf.nil?
  config['vrf-table'] = vrf_table.to_s unless vrf_table.nil?
  config['vxlan-id'] = vxlan_id.to_s unless vxlan_id.nil?
  config['vxlan-ageing'] = vxlan_ageing.to_s unless vxlan_id.nil?
  config['vxlan-local-tunnelip'] = vxlan_local_tunnelip.to_s unless vxlan_local_tunnelip.nil?
  config['vxrd-src-ip'] = vxrd_src_ip.to_s unless vxrd_src_ip.nil?
  config['vxrd-svcnode-ip'] = vxrd_svcnode_ip.to_s unless vxrd_svcnode_ip.nil?

  # Insert CLAG parameters if CLAG is enabled
  if clagd_enable
    clagd_args = data['clagd_args']
    clagd_backup_ip = data['clagd_backup_ip']
    clagd_peer_ip = data['clagd_peer_ip']
    clagd_priority = data['clagd_priority']
    clagd_sys_mac = data['clagd_sys_mac']
    clagd_vxlan_anycast_ip = data['clagd_vxlan_anycast_ip']

    config['clagd-args'] = clagd_args unless clagd_args.nil?
    config['clagd-backup-ip'] = clagd_backup_ip.to_s unless clagd_backup_ip.nil?
    config['clagd-enable'] = 'yes'
    config['clagd-peer-ip'] = clagd_peer_ip.to_s unless clagd_peer_ip.nil?
    config['clagd-priority'] = clagd_priority.to_s unless clagd_priority.nil?
    config['clagd-sys-mac'] = clagd_sys_mac.to_s unless clagd_sys_mac.nil?
    config['clagd-vxlan-anycast-ip'] = clagd_vxlan_anycast_ip.to_s unless clagd_vxlan_anycast_ip.nil?
  end

  unless speed.nil?
    config['link-speed'] = speed.to_s
    # link-duplex is always set to 'full' if link-speed is set
    config['link-duplex'] = 'full'
  end

  # Family is always 'inet' if a method is set
  addr_family = addr_method.nil? ? nil : 'inet'

  new = [{ 'auto' => true,
           'name' => name.to_s,
           'config' => config }]

  new[0]['addr_method'] = addr_method.to_s if addr_method
  new[0]['addr_family'] = addr_family.to_s if addr_family

  current = Cumulus::Utils.if_to_hash(name)

  Chef::Log.debug("current config for interface #{name} is #{current.to_json}")
  Chef::Log.debug("desired config for interface #{name} is #{new.to_json}")

  if current.nil? || current != new
    Chef::Log.debug("updating config for interface #{name}")

    intf = Cumulus::Utils.hash_to_if(name, new)

    file ::File.join(location, name) do
      owner 'root'
      group 'root'
      content intf
    end

    new_resource.updated_by_last_action(true)
  end
end
