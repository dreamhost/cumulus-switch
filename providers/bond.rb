# Copyright (C) 2015  Cumulus Networks Inc.
# Copyright (C) 2016  DreamHost
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
require 'json'

def whyrun_supported?
  true
end

use_inline_resources

action :create do
  name = new_resource.name
  data = node['cumulus']['bond'][name]

  Chef::Application.fatal!('Trying to configure a bond with no slaves =(') unless data['slaves']

  addr_method = data['addr_method']
  alias_name = data['alias']
  bridge_access = data['bridge_access']
  clag_id = data['clag_id']
  ipv4 = data['ipv4'] || []
  ipv6 = data['ipv6'] || []
  lacp_bypass_allow = data['lacp_bypass_allow']
  lacp_rate = data['lacp_rate'] || 1
  miimon = data['miimon'] || 100
  min_links = data['min_links'] || 1
  mode = data['mode'] || '802.3ad'
  mstpctl_bpduguard = data['mstpctl_bpduguard']
  mstpctl_portadminedge = data['mstpctl_portadminedge']
  mstpctl_portnetwork = data['mstpctl_portnetwork']
  mtu = data['mtu']
  post_up = data['post_up']
  pre_down = data['pre_down']
  pvid = data['pvid']
  slaves = Cumulus::Utils.prefix_glob_port_list(data['slaves'])
  vids = data['vids']
  virtual_ip = data['virtual_ip']
  virtual_mac = data['virtual_mac']
  xmit_hash_policy = data['xmit_hash_policy'] || 'layer3+4'

  location = new_resource.location

  address = ipv4 + ipv6

  config = { 'bond-slaves' => slaves.join(' '),
             'bond-min-links' => min_links.to_s,
             'bond-mode' => mode.to_s,
             'bond-miimon' => miimon.to_s,
             'bond-lacp-rate' => lacp_rate.to_s,
             'bond-xmit-hash-policy' => xmit_hash_policy.to_s }

  # Insert optional parameters
  config['address'] = address unless address.nil?
  # If single address, don't use an array (for ifquery -o json equality test)
  config['address'] = address[0] if address.class == Array && address.count == 1
  config['address-virtual'] = [virtual_mac, virtual_ip].compact.join(' ') unless virtual_ip.nil? && virtual_mac.nil?
  config['alias'] = alias_name.to_s unless alias_name.nil?
  config['bond-lacp-bypass-allow'] = lacp_bypass_allow.to_s unless lacp_bypass_allow.nil?
  config['bridge-pvid'] = pvid.to_s unless pvid.nil?
  config['bridge-vids'] = vids unless vids.nil?
  config['bridge-access'] = bridge_access.to_s unless bridge_access.nil?
  config['clag-id'] = clag_id.to_s unless clag_id.nil?
  config['mstpctl-bpduguard'] = Cumulus::Utils.bool_to_yn(mstpctl_bpduguard) unless mstpctl_bpduguard.nil?
  config['mstpctl-portadminedge'] = Cumulus::Utils.bool_to_yn(mstpctl_portadminedge) unless mstpctl_portadminedge.nil?
  config['mstpctl-portnetwork'] = Cumulus::Utils.bool_to_yn(mstpctl_portnetwork) unless mstpctl_portnetwork.nil?
  config['mtu'] = mtu.to_s unless mtu.nil?
  config['post-up'] = post_up unless post_up.nil?
  config['pre-down'] = pre_down unless post_up.nil?

  # Family is always 'inet' if a method is set
  addr_family = addr_method.nil? ? nil : 'inet'

  new = [{ 'auto' => true,
           'name' => name.to_s,
           'config' => config }]

  new[0]['addr_method'] = addr_method.to_s if addr_method
  new[0]['addr_family'] = addr_family.to_s if addr_family

  current = Cumulus::Utils.if_to_hash(name)

  Chef::Log.debug("current config for bond #{name} is #{current.to_json}")
  Chef::Log.debug("desired config for bond #{name} is #{new.to_json}")

  if current.nil? || current != new
    Chef::Log.debug("updating config for bond #{name}")

    intf = Cumulus::Utils.hash_to_if(name, new)

    file ::File.join(location, name) do
      owner 'root'
      group 'root'
      content intf
    end

    new_resource.updated_by_last_action(true)
  end
end
