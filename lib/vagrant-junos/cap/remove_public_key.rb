require 'tempfile'
require 'vagrant-junos/version'
require 'vagrant/util/shell_quote'
require 'vagrant/util/template_renderer'

module VagrantPlugins
  module GuestJunos
    module Cap
      # remove vagrant insecure public key (or anything called)
      class RemovePublicKey
        include Vagrant::Util

        def self.remove_public_key(machine, contents)
          contents = contents.chomp
          contents = ShellQuote.escape(contents, "'")

          # remove vagrant insecure public key (or anything called)
          public_key_module = TemplateRenderer.render('guest/junos/remove_public_key',
                                                      contents: contents,
                                                      template_root: "#{Dir.home}/.vagrant.d/gems/gems/vagrant-junos-#{VagrantPlugins::GuestJunos::VERSION}/templates")
          upload(machine, public_key_module, '/mfs/tmp/delete_public_key')

          # delete a public key for root
          machine.communicate.tap do |comm|
            comm.execute('cli -f /mfs/tmp/delete_public_key')
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
      end
    end
  end
end
