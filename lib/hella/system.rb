module Hella
  module System
    
    def self.included(klass)
      klass.send :attr_accessor, :connection
    end
    
    def connect(options = {})
      rc_options = self.configuration.merge(load_rc || {})
      options = case options
                when Hash
                  rc_options.merge(options)
                when String
                  # TODO parse url and port
                end
      self.connection = Connection.new(options)          
    end
    
  end
  
  class Connection
    attr_accessor :options, :gateway
    attr_reader :username, :password, :host, :port
    
    def initialize(options)
      @username, @password, @host, @port = options[:username], options[:password], options[:host], options[:port]
      self.gateway = XMLRPC::Client.new2("http://#{options[:username]}:#{options[:password]}@#{options[:host]}:#{options[:port]}")
    end
    
    def method_missing(method, *args, &block)
      gateway.send(method, *args, &block)
    end
    
  end
end