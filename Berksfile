metadata
source 'https://supermarket.chef.io'

group :test do
  cookbook 'cumulus', git: 'https://github.com/CumulusNetworks/cumulus-linux-chef-modules.git', rel: 'cookbooks/cumulus'
  cookbook 'cumulus-switch', path: '.'
  cookbook 'cumulus-switch-test', path: 'test/cookbooks/cumulus-switch-test'
end
