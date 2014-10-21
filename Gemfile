source 'https://rubygems.org'

group :development do
  gem 'vagrant', git: 'https://github.com/mitchellh/vagrant.git'
  gem 'vagrant-spec', git: 'https://github.com/mitchellh/vagrant-spec.git'
end

group :plugins do
  gem 'vagrant-junos', path: '.'
end

group 'test' do
  gem 'rake'
  gem 'chefspec'
  gem 'foodcritic'
  gem 'rubocop'
end

gemspec
