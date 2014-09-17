module VagrantPlugins
  module GuestJunos
    module Cap
      # halt because default assumes sudo
      class Halt
        def self.halt(machine)
          begin
            machine.communicate.execute('shutdown -p now')
          rescue IOError
          end
        end
      end
    end
  end
end
