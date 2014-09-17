
require 'vagrant'

module VagrantPlugins
  module GuestJunos
    # guest plugin for Junos build with root shell login
    class Guest < Vagrant.plugin('2', :guest)
      def detect?(machine)
        # machine.communicate.test("uname -s|grep 'JUNOS'", shell: '/sbin/sh')
        machine.communicate.test("uname -s|grep 'JUNOS'")
      end
    end
  end
end
