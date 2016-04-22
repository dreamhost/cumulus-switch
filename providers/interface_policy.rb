# Copyright (C) 2015  Cumulus Networks Inc.
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

action :manage do
  allowed = Cumulus::Utils.expand_port_list(new_resource.allowed)
  location = new_resource.location
  current = Dir.entries(location).reject { |f| ::File.directory? f }

  # Intersect the two lists; we want the set that is in 'current' which are NOT
  # in 'allowed'
  remove = current - allowed

  Chef::Log.debug("Removing the following interfaces: #{remove}")

  unless remove.empty?
    # Warn if 'lo' is in the list we're about to remove, as that can produce
    # odd results
    if remove.include?('lo')
      Chef::Log.warn('Removing configuration for loopback interface "lo": this may cause unexpected behaviour.')
    end

    remove.each do |intf|
      file ::File.join(location, intf) do
        action :delete
      end
    end

    new_resource.updated_by_last_action(true)
  end
end
