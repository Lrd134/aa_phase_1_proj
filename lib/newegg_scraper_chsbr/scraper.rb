

class NeweggScraperChsbr::Scraper
    attr_reader :xml_obj
    
    URL = "https://www.newegg.com/p/pl?d=cpu"
    def initialize(url = URL)
        @xml_obj = Nokogiri::HTML(open(url))  # This opens the URL with open-uri, then parses it as an XML Object
    end
    


end