require 'xmlrpc/client'
require 'hella/configuration'
require 'hella/system'
require 'hella/daemon'
require 'hella/queue'

#
# Available Options: => ["force", "process", "dequeue", "move", "down", "cancel", "shutdown", "asciiart", "aolsay", "setrarpass", "enqueueurl", "next", "maxrate", 
# "status", "enqueuenewzbin", "enqueue", "pause", "last", "clear", "list", "up", "continue", "system.methodHelp", "system.listMethods", "system.methodSignature"]
#

module Hella
  attr_accessor :instance
  
  class Version
    MAJOR, MINOR, TINY = 0, 0, 1
    class << self
      def to_s
        [MAJOR, MINOR, TINY].join('.')
      end
    end
  end
  
  class Base
    include Configuration, System, Daemon, Queue

    DEFAULTS = { :username => 'hellanzb', :password => 'changeme', :host => 'localhost', :port => 8760, :dotfile => File.expand_path('~/.hellarb') }
    
    def initialize(options = {})
      self.configuration = DEFAULTS.merge(options)
    end
    
    def method_missing(method, *args, &block)
      if connection
        connection.send(method, *args, &block)
      end
    end
    
    def hcall(method, *args)
      if connection
        begin
          connection.gateway.call(method.to_s, *args)
        rescue
          raise_or_die('Cannot connect to Hellanzb via XMLRPC')
        end
      end
    end
    
    def raise_or_die(message)
      defined?(:die) ? die(message) : raise(message)
    end
    
  end
  
  def self.connect(options = {})
    base = Base.new(options)
    base.connect
    base
  end
  
end