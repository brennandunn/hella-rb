
# Gem::Specification for Hella-rb-0.0.1
# Originally generated by Echoe

--- !ruby/object:Gem::Specification 
name: hella-rb
version: !ruby/object:Gem::Version 
  version: 0.0.1
platform: ruby
authors: 
- Brennan Dunn
autorequire: 
bindir: bin

date: 2008-06-29 00:00:00 -04:00
default_executable: 
dependencies: 
- !ruby/object:Gem::Dependency 
  name: echoe
  type: :development
  version_requirement: 
  version_requirements: !ruby/object:Gem::Requirement 
    requirements: 
    - - ">="
      - !ruby/object:Gem::Version 
        version: "0"
    version: 
description: Hella allows for easy access via XMLRPC to Hellanzb
email: me@brennandunn.com
executables: 
- hellarb
extensions: []

extra_rdoc_files: 
- lib/hella/base.rb
- lib/hella/configuration.rb
- lib/hella/daemon.rb
- lib/hella/interactive.rb
- lib/hella/queue.rb
- lib/hella/system.rb
- lib/hella/version.rb
- lib/hella.rb
- README.rdoc
files: 
- bin/hellarb
- lib/hella/base.rb
- lib/hella/configuration.rb
- lib/hella/daemon.rb
- lib/hella/interactive.rb
- lib/hella/queue.rb
- lib/hella/system.rb
- lib/hella/version.rb
- lib/hella.rb
- Manifest
- Rakefile
- README.rdoc
- setup.rb
- test/configuration_test.rb
- test/connect_test.rb
- test/interactive_test.rb
- test/util.rb
- hella-rb.gemspec
has_rdoc: true
homepage: http://www.brennandunn.com
post_install_message: 
rdoc_options: 
- --line-numbers
- --inline-source
- --title
- Hella-rb
- --main
- README.rdoc
require_paths: 
- lib
required_ruby_version: !ruby/object:Gem::Requirement 
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      version: "0"
  version: 
required_rubygems_version: !ruby/object:Gem::Requirement 
  requirements: 
  - - "="
    - !ruby/object:Gem::Version 
      version: "1.2"
  version: 
requirements: []

rubyforge_project: hella-rb
rubygems_version: 1.2.0
specification_version: 2
summary: Hella allows for easy access via XMLRPC to Hellanzb
test_files: 
- test/configuration_test.rb
- test/connect_test.rb
- test/interactive_test.rb
