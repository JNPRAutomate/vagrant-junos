module Vagrant
  module GuestJunos
    module Cap
      # host name change capability - needs to be Junos-aware
      class ChangeHostName
        def self.change_host_name(machine, name)
          machine.communicate.tap do |comm|
            unless comm.test("hostname | grep '^#{name}$'")
              comm.tap('cli')
              comm.tap('conf')
              comm.tap("set system host-name #{name.split('.')[0]}")
              comm.tap('commit and-quit')
              comm.tap('exit')
            end
          end
        end
      end
    end
  end
end
