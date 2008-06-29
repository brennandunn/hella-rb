require 'rubygems'
require 'fileutils'
require 'trollop' ; include Trollop
require 'yaml'

$interactive = true

$opts = options do
  version "hella-rb #{Hella::Version.to_s}"
  opt :config, 'Configuration file', :default => File.expand_path('~/.hellarb')
end

cmd = ARGV.shift or die 'expecting a command'
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