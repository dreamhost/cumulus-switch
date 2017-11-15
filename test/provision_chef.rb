Vagrant.configure('2') do |config|
  config.vm.provision :shell, inline: 'apt-get update && apt-get install chef && ln -s /usr/bin/chef-solo /bin/chef-solo'

  ## line for obtaining specific version of chef for testing
  #config.vm.provision :shell, inline: 'apt-get update && apt-get install curl && curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -v 12.21.26 && ln -s /usr/bin/chef-solo /bin/chef-solo'
end
