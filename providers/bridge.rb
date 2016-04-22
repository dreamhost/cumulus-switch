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
def whyrun_supported?
  true
end

use_inline_resources

action :create do
  name = new_resource.name
  data = node['cumulus']['bridge'][name]

  ports = data['ports'] || []
  ipv4 = data['ipv4'] || []
  ipv6 = data['ipv6'] || []
  mtu = data['mtu']
  addr_method = data['addr_method']
  alias_name = data['alias']
  mstpctl_treeprio = data['mstpctl_treeprio']
  post_up = data['post_up']
  pre_down = data['pre_down']
  virtual_ip = data['virtual_ip']
  virtual_mac = data['virtual_mac']

  # Default to 'true' if no value provided
  stp = data['stp']
  stp = true if stp.nil?

  ports = Cumulus::Utils.prefix_glob_port_list(ports)

  location = new_resource.location

  address = ipv4 + ipv6

  config = { 'bridge-ports' => ports.join(' '),
             'bridge-stp' => Cumulus::Utils.bool_to_yn(stp) }

  # Insert optional parameters
  config['address'] = address unless address.nil?
  # If single address, don't use an array (for ifquery -o json equality test)
  config['address'] = address[0] if address.class == Array && address.count == 1
  config['mtu'] = mtu unless mtu.nil?
  config['mstpctl-treeprio'] = mstpctl_treeprio unless mstpctl_treeprio.nil?
  config['alias'] = alias_name unless alias_name.nil?
  config['address-virtual'] = [virtual_mac, virtual_ip].compact.join(' ') unless virtual_ip.nil? && virtual_mac.nil?
  config['post-up'] = post_up unless post_up.nil?
  config['pre-down'] = pre_down unless post_up.nil?

  if data['vlan_aware']
    config['bridge-vlan-aware'] = 'yes'

    # vids & pvid are valid
    vids = data['vids']
    pvid = data['pvid']

    config['bridge-vids'] = vids unless vids.nil?
    config['bridge-pvid'] = pvid unless pvid.nil?
  end

  # Family is always 'inet' if a method is set
  addr_family = addr_method.nil? ? nil : 'inet'

  new = [{ 'auto' => true,
           'name' => name,
           'config' => config }]

  new[0]['addr_method'] = addr_method if addr_method
  new[0]['addr_family'] = addr_family if addr_family

  current = Cumulus::Utils.if_to_hash(name)

  Chef::Log.debug("current config for bridge #{name} is #{current.to_json}")
  Chef::Log.debug("desired config for bridge #{name} is #{new.to_json}")

  if current.nil? || current != new
    Chef::Log.debug("updating config for bridge #{name}")

    intf = Cumulus::Utils.hash_to_if(name, new)

    file ::File.join(location, name) do
      owner 'root'
      group 'root'
      content intf
    end

    new_resource.updated_by_last_action(true)
  end
end
