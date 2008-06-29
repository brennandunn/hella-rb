module Hella
  class Version
    MAJOR, MINOR, TINY = 0, 0, 2
    
    def self.to_s
      [MAJOR, MINOR, TINY].join('.')
    end
    
  end
end