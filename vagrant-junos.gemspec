# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant/junos/version'

Gem::Specification.new do |spec|
  spec.name          = 'vagrant-junos'
  spec.version       = VagrantPlugin::Junos::VERSION
  spec.authors       = ['John Deatherage']
  spec.email         = ['jdeatherage@juniper.net']
  spec.summary       = 'A Vagrant plugin for Junos guests, e.g. Firefly Perimeter'
  spec.description   = 'A Vagrant plugin for Junos guests, e.g. Firefly Perimeter'
  spec.homepage      = 'https://github.com/JNPRAutomate/vagrant-junos'
  spec.license       = 'Apache-2.0'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '< 1.7.0', '>= 1.5.2'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec-core', '~> 2.14'
  spec.add_development_dependency 'rspec-expectations', '~> 2.14'
  spec.add_development_dependency 'rspec-mocks', '~> 2.14'
end
