Vagrant.configure("2") do |config|
  config.vm.box = "CumulusVX-2.5.3-4eb681f3df86c478"
  config.vm.box_url = "https://objects.dreamhost.com/public-github/vagrant/boxes/CumulusVX-2.5.3-4eb681f3df86c478.box"
  config.ssh.private_key_path = "~/.ssh/bootstrap"
  config.nfs.functional = false

  config.vm.define :cumulusvx do |node|
    node.vm.hostname = "cumulusvx"

    # switch ports
    node.vm.network :private_network, ip: '10.10.10.100' # swp1
    node.vm.network :private_network, ip: '10.10.10.2' # swp2
    node.vm.network :private_network, ip: '10.10.10.3' # swp3
    node.vm.network :private_network, ip: '10.10.10.4' # swp4
    node.vm.network :private_network, ip: '10.10.10.5' # swp5
    node.vm.network :private_network, ip: '10.10.10.6' # swp6
    node.vm.network :private_network, ip: '10.10.10.7' # swp7
    node.vm.network :private_network, ip: '10.10.10.8' # swp8
    node.vm.network :private_network, ip: '10.10.10.9' # swp9
    node.vm.network :private_network, ip: '10.10.10.10' # swp10
    node.vm.network :private_network, ip: '10.10.10.11' # swp11
    node.vm.network :private_network, ip: '10.10.10.12' # swp12
    node.vm.network :private_network, ip: '10.10.10.13' # swp13
    node.vm.network :private_network, ip: '10.10.10.14' # swp14
    node.vm.network :private_network, ip: '10.10.10.15' # swp15
    node.vm.network :private_network, ip: '10.10.10.16' # swp16
    node.vm.network :private_network, ip: '10.10.10.17' # swp17
    node.vm.network :private_network, ip: '10.10.10.18' # swp18
    node.vm.network :private_network, ip: '10.10.10.19' # swp19
    node.vm.network :private_network, ip: '10.10.10.20' # swp20
    node.vm.network :private_network, ip: '10.10.10.21' # swp21
    node.vm.network :private_network, ip: '10.10.10.22' # swp22
    node.vm.network :private_network, ip: '10.10.10.23' # swp23
    node.vm.network :private_network, ip: '10.10.10.24' # swp24
    node.vm.network :private_network, ip: '10.10.10.25' # swp25
    node.vm.network :private_network, ip: '10.10.10.26' # swp26
    node.vm.network :private_network, ip: '10.10.10.27' # swp27
    node.vm.network :private_network, ip: '10.10.10.28' # swp28
    node.vm.network :private_network, ip: '10.10.10.29' # swp29
    node.vm.network :private_network, ip: '10.10.10.30' # swp30
    node.vm.network :private_network, ip: '10.10.10.31' # swp31
    node.vm.network :private_network, ip: '10.10.10.32' # swp32
    node.vm.network :private_network, ip: '10.10.10.33' # swp33
    node.vm.network :private_network, ip: '10.10.10.34' # swp34
    node.vm.network :private_network, ip: '10.10.10.35' # swp35
    node.vm.network :private_network, ip: '10.10.10.36' # swp36
    node.vm.network :private_network, ip: '10.10.10.37' # swp37
    node.vm.network :private_network, ip: '10.10.10.38' # swp38
    node.vm.network :private_network, ip: '10.10.10.39' # swp39
    node.vm.network :private_network, ip: '10.10.10.40' # swp40
    node.vm.network :private_network, ip: '10.10.10.41' # swp41
    node.vm.network :private_network, ip: '10.10.10.42' # swp42
    node.vm.network :private_network, ip: '10.10.10.43' # swp43
    node.vm.network :private_network, ip: '10.10.10.44' # swp44
    node.vm.network :private_network, ip: '10.10.10.45' # swp45
    node.vm.network :private_network, ip: '10.10.10.46' # swp46
    node.vm.network :private_network, ip: '10.10.10.47' # swp47
    node.vm.network :private_network, ip: '10.10.10.48' # swp48
    node.vm.network :private_network, ip: '10.10.10.49' # swp49
    node.vm.network :private_network, ip: '10.10.10.50' # swp50

    node.vm.provider :libvirt do |domain|
      # your milage may vary here.. some host
      # cpu's wont be happy with cumuluslinux.
      domain.driver = 'kvm'
      domain.cpu_mode = 'host-model'
      domain.nested = true
      domain.cpus = 1
      domain.memory = 2048
      domain.nic_adapter_count = 50

    end
  end

  config.vm.provision "chef_zero" do |chef|
    chef.cookbooks_path = "./"
    chef.add_recipe 'cumulusvx::default'
  end
end
