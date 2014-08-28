
require 'vagrant'

module VagrantPlugins
  module GuestJunos
    class Plugin < Vagrant.plugin('2')
      name 'Junos guest'
      description 'Junos guest support.'

      guest('junos')  do
        require File.expand_path('../guest', __FILE__)
        Guest
      end

      guest_capability('junos', 'change_host_name') do
        require_relative 'cap/change_host_name'
        Cap::ChangeHostName
      end

      guest_capability('junos', 'configure_networks') do
        require_relative 'cap/configure_networks'
        Cap::ConfigureNetworks
      end

      guest_capability('junos', 'halt') do
        require_relative 'cap/halt'
        Cap::Halt
      end

      guest_capability('junos', 'insert_public_key') do
        require_relative 'cap/insert_public_key'
        Cap::InsertPublicKey
      end
    end
  end
end
