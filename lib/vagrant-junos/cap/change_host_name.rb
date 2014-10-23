require 'tempfile'
require 'vagrant-junos/version'
require 'vagrant/util/template_renderer'

module VagrantPlugins
  module GuestJunos
    module Cap
      # host name change capability - needs to be Junos-aware
      class ChangeHostName
        include Vagrant::Util

        def self.change_host_name(machine, name)
          machine.communicate.tap do |comm|
            unless comm.test("hostname | grep '^#{name}$'")

              # render template, based on Vagrantfile, and upload
              hostname_module = TemplateRenderer.render('guest/junos/hostname',
                                                        name: name,
                                                        template_root: "#{Dir.home}/.vagrant.d/gems/gems/vagrant-junos-#{VagrantPlugins::GuestJunos::VERSION}/templates")
              upload(machine, hostname_module, '/mfs/tmp/set_hostname')

              # set up us the Junos interfaces
              comm.execute('cli -f /mfs/tmp/set_hostname')
              comm.execute('rm /mfs/tmp/set_hostname')
            end
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
