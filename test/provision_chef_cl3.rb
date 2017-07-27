Vagrant.configure('2') do |config|
  config.vm.provision :shell, inline: 'wget --quiet https://packages.chef.io/files/stable/chef/12.21.3/debian/8/chef_12.21.3-1_amd64.deb && dpkg -i chef_12.21.3-1_amd64.deb && ln -s /usr/bin/chef-solo /bin/chef-solo'
end
