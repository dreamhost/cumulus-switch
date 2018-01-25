# Copyright (C) 2018 DreamHost
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

action :createv2 do
  name = new_resource.switchd
  if node['cumulus']['switchd'].empty?
    cookbook_file '/etc/cumulus/switchd.conf' do
      source 'switchd-2.conf'
      owner 'root'
      group 'root'
      mode '0644'
    end

  else
    node.default['cumulus']['switchd']['logging'] = 'file=>/var/log/switchd.log=INFO'

    template '/etc/cumulus/switchd.conf' do
      source 'switchd.erb'
      owner 'root'
      group 'root'
      mode '0644'
    end
  end
end

action :create do
  name = new_resource.name
  if node['cumulus']['switchd'].empty?
    cookbook_file '/etc/cumulus/switchd.conf' do
      source 'switchd-2.conf'
      owner 'root'
      group 'root'
      mode '0644'
    end

  else
    node.default['cumulus']['switchd']['acl.non_atomic_update_mode'] = 'FALSE'
    node.default['cumulus']['switchd']['logging'] = 'syslog=INFO'
    node.default['cumulus']['switchd']['ignore_non_swps'] = 'TRUE'

    template '/etc/cumulus/switchd.conf' do
      source 'switchd.erb'
      owner 'root'
      group 'root'
      mode '0644'
    end
  end
end
