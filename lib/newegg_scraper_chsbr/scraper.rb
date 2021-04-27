
class NeweggScraperChsbr::Scraper
    attr_reader :xml_obj
    
    URL = "https://www.newegg.com/p/pl?d=cpu"
    def initialize(url = URL)
        @xml_obj = Nokogiri::HTML(URI.open(url)) 
    end
    


end