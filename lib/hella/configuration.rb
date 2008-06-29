module Hella
  module Configuration
    def self.included(klass)
      klass.send :attr_accessor, :configuration
    end
    
    def load_rc
      file = configuration[:dotfile]
      if File.exists?(file)
        File.open(file) { |f| YAML.load(f) }
      end
    end
    
    def write_rc
      File.open(File.expand_path(configuration[:dotfile]), 'w') do |out|
        YAML.dump({
          :host => 'localhost', 
          :port => 8760, 
          :username => 'hellanzb', 
          :password => 'changeme', 
          :binary => "#{`which hellanzb.py`.gsub("\n", '')}"
        }, out)
      end
      say "Wrote configuration file to #{configuration[:dotfile]}"
    end
    
    def log
      hcall(:status)['log_entries'].reverse.map { |hsh| Log.new(hsh.keys.first, hsh.values.first) }
    end
    
    def say(message)
      puts(message) if $interactive
    end
    
    class Log
      attr_accessor :type, :message
      def initialize(type, message)
        @type, @message = type, message
      end
      
      [:info].each do |type|
        define_method("#{type}?") do
          @type =~ /#{type}/i
        end
      end
      
      def inspect
        "#{type}: #{message}"
      end
      alias :to_s :inspect
    end
    
  end
end