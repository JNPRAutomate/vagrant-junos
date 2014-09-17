module VagrantPlugins
  module GuestJunos
    module Cap
      # host name change capability - needs to be Junos-aware
      class ChangeHostName
        def self.change_host_name(machine, name)
          unless machine.communicate.test("hostname | grep '^#{name}$'")
            machine.communicate.execute('cli')
            machine.communicate.execute('configure')
            machine.communicate.execute("set system host-name #{name.split('.')[0]}")
            machine.communicate.execute('commit and-quit')
            machine.communicate.execute('exit')
            machine.communicate.execute('exit')
          end
        end
      end
    end
  end
end
