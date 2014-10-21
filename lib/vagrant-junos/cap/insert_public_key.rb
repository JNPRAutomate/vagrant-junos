require 'vagrant/util/shell_quote'
require 'tempfile'

require 'vagrant/util/template_renderer'

module VagrantPlugins
  module GuestJunos
    module Cap
      # change root's public key
      class InsertPublicKey
        def self.insert_public_key(machine, contents)
          contents = Vagrant::Util::Shellquote.escape(contents, "'")
          contents = contents.gsub("\n", "\\n")

          # render public key junos conf template, based on Vagrantfile, and upload
          public_key_module = TemplateRenderer.render('guests/junos/public_key', contents)
          upload(machine, public_key_module, '/mfs/tmp/public_Key')

          # set up us root's public key
          machine.communicate.tap do |comm|
            comm.execute('cli -f /mfs/tmp/public_key')
            comm.execute('rm /mfs/tmp/public_key')
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
