require 'rubygems'
require 'fileutils'
require 'trollop' ; include Trollop
require 'yaml'

$interactive = true
cmd = ARGV.shift or die 'expecting a command'
hella = Hella.connect

out = case cmd
      when 'rc'           : hella.write_rc
      when 'log'          : hella.say(hella.log.map { |l| l.to_s }.join("\n"))
      when 'cancel'       : hella.cancel
      when 'pause'        : hella.pause
      when 'resume'       : hella.resume
      when 'queue:size'   : hella.say(hella.queue.total_size.to_s + 'mb')
      when 'queue:add'    : hella.queue.add(*ARGV)
      when 'queue:clear'  : hella.queue.clear
      end