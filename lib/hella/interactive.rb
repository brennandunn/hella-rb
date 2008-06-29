require 'rubygems'
require 'fileutils'
require 'trollop' ; include Trollop
require 'yaml'

$interactive = true

$opts = options do
  version "hella-rb #{Hella::Version.to_s}"
  opt :config, 'Configuration file', :default => File.expand_path('~/.hellarb')
  opt :tasks, 'List tasks'
end

if $opts[:tasks]
  puts <<-EOS
hella-rb #{Hella::Version.to_s}
------------------------
Usage: hellarb <command> <optional arguments>

Commands:
  rc            Writes configuration file to #{File.expand_path('~/.hellarb')}
  log           List log entries produced by Hellanzb
  cancel        Cancel downloads
  pause         Pause downloads
  resume        Resume downloads
  toggle        Pause if Hellanzb is active, resume if paused
  queue:size    Amount of MB queued for download
  queue:add     Space seperated list of newzbin IDs. e.g. queue:add 12345 67890
  system        Call directly to Hellanzb without going through hella-rb
  
More information can be found at http://www.brennandunn.com  
  
  EOS
end

cmd = ARGV.shift or die 'expecting a command' unless $opts[:tasks]
hella = Hella.connect
hella.configuration[:dotfile] = $opts[:config]

unless hella.connected?
  return 'Hellanzb is not online. Run `hellarb start` to attempt to start it'
end

out = case cmd
      when 'rc'           : hella.write_rc
      when 'log'          : hella.say(hella.log.map { |l| l.to_s }.join("\n"))
      when 'cancel'       : hella.cancel
      when 'pause'        : hella.pause
      when 'resume'       : hella.resume
      when 'toggle'       : hella.toggle
      when 'queue:size'   : hella.say(hella.queue.total_size.to_s + 'mb')
      when 'queue:add'    : hella.queue.add(*ARGV)
      when 'queue:clear'  : hella.queue.clear
      when 'system'       : hella.call(*ARGV) ; hella.say("Command issued: #{ARGV.join(' ')}")
      end