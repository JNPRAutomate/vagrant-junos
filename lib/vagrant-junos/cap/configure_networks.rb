require 'ipaddr'
require 'tempfile'
require 'vagrant-junos/version'
require 'vagrant/util/template_renderer'

module VagrantPlugins
  module GuestJunos
    module Cap
      # Configure Junos network interfaces
      module ConfigureNetworks
        include Vagrant::Util

        def self.configure_networks(machine, networks)
          # set the prefix length
          networks.each do |network|
            network[:prefix_length] = (network[:netmask] && netmask_to_cidr(network[:netmask]))
          end

          # render template based on Vagrantfile, and upload
          network_module = TemplateRenderer.render('guest/junos/network',
                                                   options: networks,
                                                   template_root: "#{Dir.home}/.vagrant.d/gems/gems/vagrant-junos-#{VagrantPlugins::GuestJunos::VERSION}/templates")
          upload(machine, network_module, '/mfs/tmp/network')
          deploy(machine)
        end

        # Upload a file.
        def self.upload(machine, content, remote_temp)
          local_temp = Tempfile.new('vagrant-upload')
          local_temp.binmode
          local_temp.write(content)
          local_temp.close
          machine.communicate.upload(local_temp.path, "#{remote_temp}")
          local_temp.delete
        end

        # set up us the Junos interfaces
        def self.deploy(machine)
          machine.communicate.tap do |comm|
            comm.execute('cli -f /mfs/tmp/network')
          end
        end

        # convert vagrant dotted-decimal notation to cidr
        def self.netmask_to_cidr(mask)
          IPAddr.new(mask).to_i.to_s(2).count('1')
        end
      end
    end
  end
end
