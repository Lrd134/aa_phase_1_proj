class NeweggScraperChsbr::Shipping
    attr_reader :price
    def initialize(shipping_price)
        @price = shipping_price
    end
end