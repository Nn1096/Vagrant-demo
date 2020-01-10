# -*- mode: ruby -*-
# vi: set ft=ruby foldmethod=marker :

## Petit contrat tacite entre nous :)
# dmz0     => reseau DMZ (10.0.3.0/24)
# user0  => reseau USER (10.0.4.0/24)

Vagrant.configure('2') do |config|
  if Vagrant.has_plugin?('vagrant-proxyconf')# {{{
    puts 'Vagrant detected the proxy plugin'
    if ENV['http_proxy']
      puts "Using HTTP PROXY #{ENV['http_proxy']}"
      config.proxy.http = ENV['http_proxy']
    end

    if ENV['https_proxy']
      puts "Using HTTPS PROXY #{ENV['https_proxy']}"
      config.proxy.https = ENV['https_proxy']
    end

    if ENV['no_proxy']
      puts "Using NO_PROXY #{ENV['no_proxy']}"
      config.proxy.no_proxy = ENV['no_proxy']
    end
  end# }}}

  # cherche a updater la box a chaque up
  config.vm.box_check_update = false

    #
  # Router
  #
  config.vm.define 'router' do |machine|
    machine.vm.box = 'debian/buster64'

    machine.vm.provider 'virtualbox' do |vb|
      vb.memory = '1024'
      vb.customize ['modifyvm', :id, '--macaddress1', 'AABBCC000002']
    end

    machine.vm.network 'private_network',
                       auto_config: false,
                       virtualbox__intnet: 'dmz0'

    machine.vm.network 'private_network',
                       auto_config: false,
                       virtualbox__intnet: 'user0'

    machine.vm.provision 'shell', path: 'provisioning/router.sh'
  end

  #
  # Services
  #
  config.vm.define 'services' do |machine|
    machine.vm.box = 'debian/buster64'

    machine.vm.provider 'virtualbox' do |vb|
      vb.memory = '1024'
      vb.customize ['modifyvm', :id, '--macaddress1', 'AABBCC000003']
    end

    machine.vm.network 'private_network',
                       auto_config: false,
                       virtualbox__intnet: 'dmz0'

    machine.vm.provision 'shell', path: 'provisioning/services.sh'
  end


  #
  # Client
  #
  config.vm.define 'client' do |machine|
    # DNS / DHCP
    machine.vm.box = 'debian/buster64'

    machine.vm.provider 'virtualbox' do |vb|
      vb.memory = '1024'
      vb.customize ['modifyvm', :id, '--macaddress1', 'AABBCC000001']
    end

    machine.vm.network 'private_network',
                       auto_config: false,
                       virtualbox__intnet: 'user0'

    machine.vm.provision 'shell', path: 'provisioning/client.sh'
  end
end

