module Hella
  module Queue
    
    def queue
      @queue ||= Queue.new(self)
    end
    
    class Queue < Array
      
      def initialize(reference)
        @ref = reference
      end
      
      def add(*ids_or_urls)
        ids_or_urls.map do |id_or_url|
          case id_or_url
          when Integer, /\d+/
            hcall(:enqueuenewzbin, id_or_url)
          else
            hcall(:enqueue, id_or_url)
          end
          true
        end.all?
      end
      
      def clear
        hcall(:clear)
        say('Clearing future queue')
      end
      
      def total_size
        hcall(:status)['queued_mb'].to_f
      end
      
      def percent_complete
        hcall(:percent_complete)
      end
      
      def method_missing(method, *args, &block)
        @ref.send(method, *args, &block)
      end
      
    end
    
  end
end