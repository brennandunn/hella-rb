module Hella
  class Version
    MAJOR, MINOR, TINY = 0, 0, 1
    
    def self.to_s
      [MAJOR, MINOR, TINY].join('.')
    end
    
  end
end