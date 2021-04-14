require_relative '../config/environment.rb'

class Scraper
    attr_reader :xml_obj
    
    URL = "https://www.newegg.com/p/pl?d=cpu"
    def initialize
        @xml_obj = Nokogiri::HTML(open(URL))  # This opens the URL with open-uri, then parses it as an XML Object
    end



end