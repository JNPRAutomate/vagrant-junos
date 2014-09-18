require 'vagrant/util/shell_quote'
require 'tempfile'

module VagrantPlugins
  module GuestJunos
    module Cap
      # change root's public key
      class InsertPublicKey
        def self.insert_public_key(machine, contents)
          contents = Vagrant::Util::Shellquote.escape(contents, "'")
          contents = contents.gsub("\n", "\\n")

          machine.communicate.tap do |comm|
            commands = <<-EOS
configure
set system root-password ssh-rsa "#{contents}"
commit and-quit
EOS
            temp = Tempfile.new('vagrant')
            temp.binmode
            temp.write(commands)
            temp.close
            comm.upload(temp.path '/mfs/tmp/set_root_key')
            comm.execute('cli -f /mfs/tmp/set_root_key')
            comm.execute('rm /mfs/tmp/set_root_key')
          end
        end
      end
    end
  end
end
