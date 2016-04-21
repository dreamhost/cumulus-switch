metadata
source 'https://supermarket.chef.io'

group :test do
  cookbook 'cumulus', git: 'https://github.com/floored1585/cumulus-linux-chef-modules.git', branch: 'removing_new_resource', rel: 'cookbooks/cumulus'
  cookbook 'cumulus-switch', path: '.'
  cookbook 'cumulus-switch-test', path: 'test/cookbooks/cumulus-switch-test'
end
