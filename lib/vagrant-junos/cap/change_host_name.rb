require 'tempfile'
# require 'vagrant/util/template_renderer'

module VagrantPlugins
  module GuestJunos
    module Cap
      # host name change capability - needs to be Junos-aware
      class ChangeHostName
        def self.change_host_name(machine, name)
          machine.communicate.tap do |comm|
            unless comm.test("hostname | grep '^#{name}$'")
              commands = <<-EOS
configure
set system host-name #{name}
commit and-quit
EOS
              Tempfile.open('vagrant') do |temp|
                temp.binmode
                temp.write(commands)
                temp.close
                comm.upload(temp.path, '/mfs/tmp/set_hostname')
              end
              comm.execute('cli -f /mfs/tmp/set_hostname')
              comm.execute('rm /mfs/tmp/set_hostname')
            end
          end
        end
      end
    end
  end
end
