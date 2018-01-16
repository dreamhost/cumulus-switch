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


case node['lsb']['release']
when /^[12]\./
  switchd_template = 'switchd-2.conf'
  switchd_options = {
    'logging' : 'file:/var/log/switchd.log=INFO',
  }
else
  switchd_template = 'switchd.conf'
  switchd_options = {
    'acl.non_atomic_update_mode' : 'FALSE',
    'logging' : 'syslog=INFO',
    'ignore_non_swps' : 'TRUE',
  }
end

if switchd.empty?
  cookbook_file '/etc/cumulus/switchd.conf' do
    source switchd_template
    owner 'root'
    group 'root'
    mode '0644'
  end
else
  node.default['cumulus']['switchd'] = switchd_options
  template '/etc/cumulus/switchd.conf' do
    source 'switchd.erb'
    owner 'root'
    group 'root'
    mode '0644'
  end
end
