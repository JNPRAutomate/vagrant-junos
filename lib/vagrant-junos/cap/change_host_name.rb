module Vagrant
  module Junos
    module Cap
      # host name change capability - needs to be Junos-aware
      class ChangeHostName
        def self.change_host_name(machine, name)
          unless machine.communicate.test("hostname | grep '^#{name}$'", shell: 'sh')
            # replace hostname in local script
            # apply with netconf
            # will later be replaced with machine.communicate.netconf commands
          end
        end
      end
    end
  end
end
