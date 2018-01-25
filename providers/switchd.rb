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

action :create do
  ## attribute release created in resources
<<<<<<< HEAD
  release = new_resource.release
=======
  release release
>>>>>>> refs/remotes/origin/master
  case release
    ## This action is for cumulus linux 1 or 2
  when /^[12]\./
    source_file = 'switchd-2.conf'
    unless node['cumulus']['switchd'].empty?
      node.default['cumulus']['switchd']['logging'] = 'file=>/var/log/switchd.log=INFO'
    end
  ## This action is for cumulus linux 3 or greater
  else
    source_file = 'switchd.conf'
    unless node['cumulus']['switchd'].empty?
      node.default['cumulus']['switchd']['acl.non_atomic_update_mode'] = 'FALSE'
      node.default['cumulus']['switchd']['logging'] = 'syslog=INFO'
      node.default['cumulus']['switchd']['ignore_non_swps'] = 'TRUE'
    end
  end
  if node['cumulus']['switchd'].empty?
    cookbook_file '/etc/cumulus/switchd.conf' do
      source source_file
      owner 'root'
      group 'root'
      mode '0644'
    end
  else
    template '/etc/cumulus/switchd.conf' do
      source 'switchd.erb'
      owner 'root'
      group 'root'
      mode '0644'
    end
  end
end
