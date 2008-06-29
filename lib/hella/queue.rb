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
          when /safari|firefox/i
            begin
              require 'hpricot'
              require 'appscript'
              self.class.send :include, Appscript
              id, title = find_from_browser(id_or_url)
              add(id)
              say("Fetching ID #{id}: #{title} from #{id_or_url}")
            rescue LoadError
              die('You need appscript installed to check based on a browser')
            end
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
      
      
      private
      
      def find_from_browser(browser)
        if browser = app(browser)
          begin
            url, source = browser.document.get.first.URL.get, browser.document.get.first.source.get
            url =~ /(\d+)/ ; id = $1.strip
            title = Hpricot(source).at('title').to_plain_text
            title =~ /:(.*)$/ ; parsed_title = $1.strip
            [id, parsed_title]
          rescue
          end
        end
      end
      
    end
    
  end
end