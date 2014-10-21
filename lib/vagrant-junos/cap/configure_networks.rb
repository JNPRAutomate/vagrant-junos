require 'tempfile'
require 'ipaddr'

require 'vagrant/util/template_renderer'

module VagrantPlugins
  module GuestJunos
    module Cap
      # Configure Junos network interfaces
      module ConfigureNetworks
        def self.configure_networks(machine, networks)
          # set the prefix length
          networks.each do |network|
            network[:prefix_length] = (network[:netmask] && netmask_to_cidr(network[:netmask]))
          end

          # render template, based on Vagrantfile, and upload
          network_module = TemplateRenderer.render('guests/junos/network', networks: networks)
          upload(machine, network_module, '/mfs/tmp/network')

          # set up us the Junos interfaces
          machine.communicate.tap do |comm|
            comm.execute('cli -f /mfs/tmp/network')
            comm.execute('rm /mfs/tmp/network')
          end
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

        # convert vagrant dotted-decimal notation to cidr
        def self.netmask_to_cidr(mask)
          IPAddr.new(mask).to_i.to_s(2).count('1')
        end
      end
    end
  end
end
