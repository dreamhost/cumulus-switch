Vagrant.configure("2") do |config|
  config.vm.box = "CumulusVX-2.5.3-4eb681f3df86c478"
  config.vm.box_url = "https://objects.dreamhost.com/public-github/vagrant/boxes/CumulusVX-2.5.3-4eb681f3df86c478.box"
  config.ssh.private_key_path = "~/.ssh/bootstrap"
  config.nfs.functional = false

  config.vm.define :cumulusvx do |node|
    node.vm.hostname = "cumulusvx"
    node.vm.provider :libvirt do |domain|
      # your milage may vary here.. some host
      # cpu's wont be happy with cumuluslinux.
      domain.driver = 'kvm'
      domain.cpu_mode = 'host-model'
      domain.nested = true
      domain.cpus = 1
      domain.memory = 2048

    end
  end

  config.vm.provision "chef_zero" do |chef|
    chef.cookbooks_path = "./"
    chef.add_recipe 'cumulusvx::default'
  end

end
