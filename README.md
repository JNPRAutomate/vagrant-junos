# [Vagrant Junos Guest](https://github.com/JNPRAutomate/vagrant-junos)

[![Build Status](https://travis-ci.org/JNPRAutomate/vagrant-junos.svg?branch=master)](https://travis-ci.org/JNPRAutomate/vagrant-junos)[![Gem Version](https://badge.fury.io/rb/vagrant-junos.svg)](http://badge.fury.io/rb/vagrant-junos)[![Code Climate](https://codeclimate.com/github/JNPRAutomate/vagrant-junos/badges/gpa.svg)](https://codeclimate.com/github/JNPRAutomate/vagrant-junos)[![Dependency Status](https://gemnasium.com/JNPRAutomate/vagrant-junos.svg)](https://gemnasium.com/JNPRAutomate/vagrant-junos)



This is a [Vagrant](http://www.vagrantup.com) 1.7+ plugin that adds a Junos guest to Vagrant, allowing for OS detection and initial configuration

> **NOTE:** This plugin requires Vagrant 1.7+,

## Features

* Detect [vSRX](http://www.juniper.net/us/en/products-services/security/srx-series/vsrx/) guest instances automatically, or via [Vagrantfile](https://docs.vagrantup.com/v2/vagrantfile/machine_settings.html).  The default boxes on [Juniper's Atlas site](http://atlas.hashicorp.com/Juniper) have `config.vm.guest` explicitly set to Junos.
* Set the hostname via [Vagrantfile](https://docs.vagrantup.com/v2/vagrantfile/machine_settings.html) - `config.vm.hostname`
* Support [Vagrantfile SSH settings](https://docs.vagrantup.com/v2/vagrantfile/ssh_settings.html) -  `config.ssh.private_key_path`, etc.
* Network configuration of ge-0/0/1.0 through ge-0/0/9.0
* __TBD__: anything you request via [issues](https://github.com/JNPRAutomate/vagrant-junos/issues)


## Usage

Install using standard Vagrant 1.6+ plugin installation methods.  The fastest way to get started is to use the standard Vagrant Cloud images:

```
$ vagrant plugin install vagrant-junos
...
$ vagrant up juniper/ffp-12.1X46-D20.5
...
```

## Quick Start

>__TODO__: Add docs on Vagrantfile settings


## Configuration

>__TODO__: Add docs on Vagrantfile settings, and Ruby snippets

## Development

To work on the `vagrant-junos` plugin, clone this repository out, and use
[Bundler](http://gembundler.com) to get the dependencies:

```
$ bundle
```

Once you have the dependencies, verify the unit tests pass with `rake`:

```
$ bundle exec rake
```

If those pass, you're ready to start developing the plugin. You can test
the plugin without installing it into your Vagrant environment by just
creating a `Vagrantfile` in the top level of this directory (it is gitignored)
and add the following line to your `Vagrantfile`
```ruby
Vagrant.require_plugin "vagrant-junos"
```
Use bundler to execute Vagrant:
```
$ bundle exec vagrant up juniper/ffp-12.1X46-D20.5
```

## Notes

> **NOTE:** post-bootstrap configuration in Vagrant will be carried out through the [vagrant-netconf](https://github.com/JNPRAutomate/vagrant-netconf) communicator plugin and [vagrant-jprovision](https://github.com/JNPRAutomate/vagrant-jprovision) provisioner plugin.  These may or may not be required in the premade boxes in the future.
