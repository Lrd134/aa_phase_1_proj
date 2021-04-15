require_relative '../config/environment.rb'

class NeweggScraperChsbr::CpuName
    attr_accessor :name
    # @@all = []
    def initialize(name)
        @name = name
    end

end