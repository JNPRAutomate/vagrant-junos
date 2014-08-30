begin
  require 'vagrant'
rescue LoadError
  raise 'The Vagrant Junos plugin must be run within Vagrant'
end

# This is a sanity check to make sure no one is attempting to install
# this into an early Vagrant version.
if Vagrant::VERSION < '1.2.0'
  raise 'The Vagrant Junos plugin is only compatible with Vagrant 1.2+'
end

module VagrantPlugins
  module Junos
    # plugin to support Junos guests
    class Plugin < Vagrant.plugin('2')
      name 'Junos'
      description <<-DESC
      This plugin installs a provider that allows Vagrant to manage
      Junos VMs, such as Firefly Perimeter
      DESC

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
