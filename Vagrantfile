# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "cumulus-vx-2.5.3"
  config.vm.box_url = "https://objects.dreamhost.com/public-github/vagrant/boxes/cumulus-vx-2.5.3-chef-vbox.box"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Internal network for swp* interfaces.
  config.vm.network "private_network", virtualbox__intnet: true # swp1
  config.vm.network "private_network", virtualbox__intnet: true # swp2
  config.vm.network "private_network", virtualbox__intnet: true # swp3
  config.vm.network "private_network", virtualbox__intnet: true # swp4
  config.vm.network "private_network", virtualbox__intnet: true # swp5
  config.vm.network "private_network", virtualbox__intnet: true # swp6
  config.vm.network "private_network", virtualbox__intnet: true # swp7
  config.vm.network "private_network", virtualbox__intnet: true # swp8
  config.vm.network "private_network", virtualbox__intnet: true # swp9
  config.vm.network "private_network", virtualbox__intnet: true # swp10
  config.vm.network "private_network", virtualbox__intnet: true # swp11
  config.vm.network "private_network", virtualbox__intnet: true # swp12
  config.vm.network "private_network", virtualbox__intnet: true # swp13
  config.vm.network "private_network", virtualbox__intnet: true # swp14
  config.vm.network "private_network", virtualbox__intnet: true # swp15
  config.vm.network "private_network", virtualbox__intnet: true # swp16
  config.vm.network "private_network", virtualbox__intnet: true # swp17
  config.vm.network "private_network", virtualbox__intnet: true # swp18
  config.vm.network "private_network", virtualbox__intnet: true # swp19
  config.vm.network "private_network", virtualbox__intnet: true # swp20
  config.vm.network "private_network", virtualbox__intnet: true # swp21
  config.vm.network "private_network", virtualbox__intnet: true # swp22
  config.vm.network "private_network", virtualbox__intnet: true # swp23
  config.vm.network "private_network", virtualbox__intnet: true # swp24
  config.vm.network "private_network", virtualbox__intnet: true # swp25
  config.vm.network "private_network", virtualbox__intnet: true # swp26
  config.vm.network "private_network", virtualbox__intnet: true # swp27
  config.vm.network "private_network", virtualbox__intnet: true # swp28
  config.vm.network "private_network", virtualbox__intnet: true # swp29
  config.vm.network "private_network", virtualbox__intnet: true # swp30
  config.vm.network "private_network", virtualbox__intnet: true # swp31
  config.vm.network "private_network", virtualbox__intnet: true # swp32
  config.vm.network "private_network", virtualbox__intnet: true # swp33
  config.vm.network "private_network", virtualbox__intnet: true # swp34
  config.vm.network "private_network", virtualbox__intnet: true # swp35

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL
  #
  config.vm.provision "chef_zero" do |chef|
    chef.cookbooks_path = "./"
    chef.add_recipe 'cumulusvx::default'
  end
end
