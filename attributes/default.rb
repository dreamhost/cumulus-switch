node.default['cumulus_attr']['bridge'] = {}
node.default['cumulus_attr']['bond'] = {}
node.default['cumulus_attr']['interface_range'] = {}
node.default['cumulus_attr']['interface'] = {}
node.default['cumulus_attr']['ports'] = {}

# Automatically restart switchd on port config changes if true
node.default['cumulus_attr']['restart_switchd'] = false
