module Hella
  module Daemon
    
    def cancel
      hcall(:cancel)
      say('Halting downloads')
    end
    
    def pause
      hcall(:pause)
      say('Pausing downloads')
    end
    
    def paused?
      hcall(:status)['is_paused']
    end
    
    def resume
      hcall(:continue)
      say('Resuming downloads')
    end
    
    def toggle
      paused? ? resume : pause
    end
    
  end
end