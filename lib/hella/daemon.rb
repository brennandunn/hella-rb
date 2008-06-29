module Hellanzb
  module Daemon
    
    def cancel
      call(:cancel)
      say('Halting downloads')
    end
    
    def pause
      call(:pause)
      say('Pausing downloads')
    end
    
    def paused?
      call(:status)['is_paused']
    end
    
    def resume
      call(:continue)
      say('Resuming downloads')
    end
    
  end
end