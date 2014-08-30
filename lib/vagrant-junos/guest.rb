
require 'vagrant'

module VagrantPlugins
  module Junos
    # guest plugin for Junos build with root shell login
    # TODO: figure out of if this could be run from junos side
    # e.g. from 'vagrant' user with 'start shell'
    # also needs to not break a Vagrant install
    # (OS detection or otherwise )
    class Guest < Vagrant.plugin('2', :guest)
      def detect?(machine)
        machine.communicate.test("uname -s|grep 'JUNOS'", shell: 'sh')
      end
    end
  end
end
