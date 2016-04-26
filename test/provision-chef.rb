Vagrant.configure("2") do |config|
  config.vm.provision :shell, inline: "apt-get update && apt-get install chef && ln -s /usr/bin/chef-solo /bin/chef-solo"
end
