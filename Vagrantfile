# -*- mode: ruby -*-
# vi: set ft=ruby :

# ge-0/0/0.0 defaults to NAT for SSH + management connectivity
# over Vagrant's forwarded ports.  This should configure ge-0/0/1.0
# through ge-0/0/7.0 on VirtualBox.

######### WARNING: testing only! #########
######### WARNING: testing only! #########
######### WARNING: testing only! #########
#
# this Vagrantfile can and will wreak havoc on your VBox setup, so please
# use the Vagrant boxes at https://atlas.hashicorp.com/juniper unless you're
# attempting to extend this plugin (and can lose your VBox network config)
# TODO: launch VMs from something other than travis to CI all features
#
# Note: VMware can't name interfaces, but also supports 10 interfaces
# (through ge-0/0/9.0), so you should adjust accordingly to test
#
# Note: interface descriptions in Junos don't work yet, but you woud set them
# here with 'description:'.


Vagrant.configure(2) do |config|
  config.vm.box = "juniper/ffp-12.1X47-D15.4-packetmode"
  config.vm.hostname = 'vagrant-junos-test'
  config.vm.network "private_network",
                    ip: "192.168.33.10",
                    virtualbox__intnet: "teststatic"
  config.vm.network "private_network",
                    type: "dhcp",
                    virtualbox__intnet: "testdhcp"
  config.vm.network "private_network",
                    ip: "192.168.34.10",
                    virtualbox__intnet: "teststatic2"
  config.vm.network "private_network",
                    type: "dhcp",
                    virtualbox__intnet: "testdhcp2"
  config.vm.network "private_network",
                    ip: "192.168.35.10",
                    virtualbox__intnet: "teststatic3"
  config.vm.network "private_network",
                    type: "dhcp",
                    virtualbox__intnet: "testdhcp3"
  config.vm.network "private_network",
                    ip: "192.168.36.10",
                    virtualbox__intnet: "teststatic4"
end
