
class NeweggScraperChsbr::Price
    attr_accessor :price
    
    def initialize(price)
        @price = price
    end
    def convert_price
        @price.slice(1 .. @price.size - 4).to_i
    end

end