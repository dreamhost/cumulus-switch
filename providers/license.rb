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
require 'uri'
require 'English'

def whyrun_supported?
  true
end

use_inline_resources

action :install do
  unless exists? && new_resource.force == false
    source = new_resource.source

    validate_url!(source)
    execute "/usr/cumulus/bin/cl-license -i #{source}"

    new_resource.updated_by_last_action(true)
  end
end

##
# Check if the license file exists
#
# = Returns:
# true if the license exists, false otherwise.
#
def exists?
  `/usr/cumulus/bin/cl-license`
  $CHILD_STATUS == 0 ? true : false
end

##
# Parse the provided source URI and stop executation if the URL is invalid
#
def validate_url!(uri_str)
  begin
    URI.parse(uri_str)
  rescue URI::InvalidURIError
    Chef::Application.fatal!("The cumulus_license source URL #{uri_str} is invalid")
  end
end
