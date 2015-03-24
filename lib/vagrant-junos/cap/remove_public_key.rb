require 'tempfile'
require 'vagrant-junos/version'
require 'vagrant/util/shell_quote'
require 'vagrant/util/template_renderer'

module VagrantPlugins
  module GuestJunos
    module Cap
      # Completely dumb check for now - only one key per user
      class RemovePublicKey
        include Vagrant::Util

        def self.remove_public_key(machine, contents)
          contents = contents.chomp
          contents = Vagrant::Util::ShellQuote.escape(contents, "'")

          machine.communicate.tap do |comm|
            comm.test("test -f ~/.ssh/authorized_keys")
            comm.execute("cat #{contents}")
          end
        end
      end
    end
  end
end
