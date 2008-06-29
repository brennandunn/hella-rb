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
    include Configuration, System, Queue

    DEFAULTS = { :username => 'hellanzb', :password => 'changeme', :host => 'localhost', :port => 8760, :dotfile => File.expand_path('~/.hellarb') }
    
    def initialize(options = {})
      self.configuration = DEFAULTS.merge(options)
    end
    
    def method_missing(method, *args, &block)
      if connection
        connection.send(method, *args, &block)
      end
    end
    
    def call(method, *args)
      if connection
        connection.gateway.call(method.to_s, *args)
      end
    end
    
  end
  
  def self.connect(options = {})
    base = Base.new(options)
    base.connect
    base
  end
  
end