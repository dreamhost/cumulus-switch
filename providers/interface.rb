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

  ipv4 = data['ipv4'] || []
  ipv6 = data['ipv6'] || []
  alias_name = data['alias']
  speed = data['speed']
  mtu = data['mtu']
  post_up = data['post_up']
  pre_down = data['pre_down']
  addr_method = data['addr_method']
  virtual_mac = data['virtual_mac']
  virtual_ip = data['virtual_ip']
  vids = data['vids']
  vrf = data['vrf']
  vrf_table = data['vrf_table']
  pvid = data['pvid']
  clagd_enable = data['clagd_enable']
  mstpctl_portnetwork = data['mstpctl_portnetwork']
  mstpctl_portadminedge = data['mstpctl_portadminedge']
  mstpctl_bpduguard = data['mstpctl_bpduguard']

  location = new_resource.location

  address = ipv4 + ipv6

  config = {}

  # Insert optional parameters
  config['address'] = address unless address.nil?
  # If single address, don't use an array (for ifquery -o json equality test)
  config['address'] = address[0] if address.class == Array && address.count == 1
  config['alias'] = alias_name unless alias_name.nil?
  config['mtu'] = mtu unless mtu.nil?
  config['bridge-vids'] = vids unless vids.nil?
  config['bridge-pvid'] = pvid unless pvid.nil?
  config['address-virtual'] = [virtual_mac, virtual_ip].compact.join(' ') unless virtual_ip.nil? && virtual_mac.nil?
  config['post-up'] = post_up unless post_up.nil?
  config['pre-down'] = pre_down unless pre_down.nil?
  config['mstpctl-portnetwork'] = Cumulus::Utils.bool_to_yn(mstpctl_portnetwork) unless mstpctl_portnetwork.nil?
  config['mstpctl-portadminedge'] = Cumulus::Utils.bool_to_yn(mstpctl_portadminedge) unless mstpctl_portadminedge.nil?
  config['mstpctl-bpduguard'] = Cumulus::Utils.bool_to_yn(mstpctl_bpduguard) unless mstpctl_bpduguard.nil?
  config['vrf'] = vrf unless vrf.nil?
  config['vrf-table'] = vrf_table unless vrf_table.nil?

  # Insert CLAG parameters if CLAG is enabled
  if clagd_enable
    clagd_peer_ip = data['clagd_peer_ip']
    clagd_priority = data['clagd_priority']
    clagd_sys_mac = data['clagd_sys_mac']
    clagd_args = data['clagd_args']

    config['clagd-enable'] = 'yes'
    config['clagd-peer-ip'] = clagd_peer_ip unless clagd_peer_ip.nil?
    config['clagd-priority'] = clagd_priority unless clagd_priority.nil?
    config['clagd-sys-mac'] = clagd_sys_mac unless clagd_sys_mac.nil?
    config['clagd-args'] = "\"#{clagd_args}\"" unless clagd_args.nil?
  end

  unless speed.nil?
    config['link-speed'] = speed
    # link-duplex is always set to 'full' if link-speed is set
    config['link-duplex'] = 'full'
  end

  # Family is always 'inet' if a method is set
  addr_family = addr_method.nil? ? nil : 'inet'

  new = [{ 'auto' => true,
           'name' => name,
           'config' => config }]

  new[0]['addr_method'] = addr_method if addr_method
  new[0]['addr_family'] = addr_family if addr_family

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
