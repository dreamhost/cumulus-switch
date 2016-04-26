node.default['cumulus']['bridge'] = {}
node.default['cumulus']['bond'] = {}
node.default['cumulus']['interface_range'] = {}
node.default['cumulus']['interface'] = {}
node.default['cumulus']['ports'] = {}

# Automatically restart switchd on port config changes if true
node.default['cumulus']['restart_switchd'] = false
node.default['cumulus']['reload_networking'] = true
