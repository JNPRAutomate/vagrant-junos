require 'pathname'

require 'vagrant-junos/plugin'

# Vagrant's plugin API
# http://docs.vagrantup.com/v2/plugins/guests.html
# http://docs.vagrantup.com/v2/plugins/guest-capabilities.html
module VagrantPlugins
  # A guest plugin for Juniper's Junos network OS.
  # This communicates with the BSD shell of Junos,
  # which matches other Vagrant guest plugin behavior.
  module GuestJunos
    lib_path = Pathname.new(File.expand_path('../vagrant-junos', __FILE__))
    autoload :Action, lib_path.join('action')
    autoload :Errors, lib_path.join('errors')
  end

  # This returns the path to the source of this plugin.
  #
  # @return [Pathname]
  def self.source_root
    @source_root ||= Pathname.new(File.expand_path('../../', __FILE__))
  end
end
