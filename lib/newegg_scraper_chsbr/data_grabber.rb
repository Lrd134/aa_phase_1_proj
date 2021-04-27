class NeweggScraperChsbr::DataGrabber
    attr_reader :cpus


    def initialize()
        shipping_price = getShipping
        prices = getPrice
        names = getNames
        descHash = getCpuDesc
        @cpus = makeCpus(prices, names, shipping_price, descHash)                     
    end 

    def getCpuDesc
        scraped = NeweggScraperChsbr::Scraper.new
        pages = []
        description = []
        css_next_link = scraped.xml_obj.css  ".item-title"
        css_next_link.each_with_index do | element, index |
            if index != 0
        
                if element.attributes["href"] != nil
                    pages << element.attributes["href"].text
                end
            end
        end
        description = {}
        counter = 1
        puts "Getting data.. Please wait.\n"
        pages.each_with_index do | url, index_of_pages |
            description[index_of_pages] = {}
            scraped_info = NeweggScraperChsbr::Scraper.new(url)
            descriptors = scraped_info.xml_obj.css(".product-bullets")
            descriptors.children.children.each do |info |
                info.children.each do | more_info |
                    
                    description[index_of_pages][counter] = more_info.text
                    counter += 1 
                end 
            end
            counter = 0
            
        end
        puts "Done!\n"
        description
        


    end
    def split_price(html_element)              
        counter = 0
        until counter == 100  
            if counter < 10                    
                if html_element.text.include?(".0#{counter.to_s}")  
                                                                   
                    price = html_element.text.split ".0#{counter.to_s}" 
                                                                        
                                                                        
                    price.delete_at 1
                    return price, ".0#{counter.to_s}"                   
                end
            elsif counter >= 10                                     
                if html_element.text.include?(".#{counter.to_s}") 

                    price = (html_element.text.split ".#{counter.to_s}")
                    price.delete_at 1 
                    return price, (".#{counter.to_s}")
                end
            end
        counter += 1
        end
    end
    def isCoolerOrMB?(name) 
        name.include?("Water") || name.include?("Air") || name.include?("Motherboard") || name.include?("AIO") || name.include?("FLY")
    end
    def getPrice
        scraped_info = NeweggScraperChsbr::Scraper.new
        css_price = scraped_info.xml_obj.css ".price-current"    

        prices = []                                        

        css_price.each do | piece |                        
            temp_price = split_price piece                 
            if temp_price != nil
                temp_price.flatten!                             
                prices << "#{temp_price[0]}#{temp_price[1]}"    
            end

        end 
        prices
    end
    def getNames
        scraped = NeweggScraperChsbr::Scraper.new
        names = []                                          

        css_name = scraped.xml_obj.css ".item-title"       

        css_name.each_with_index do | name, index |        

            index != 0 ? names << name.text : nil           
        end 
        names
    end
    def getShipping
        scraped = NeweggScraperChsbr::Scraper.new
        shipping = []
        css_shipping = scraped.xml_obj.css ".price-ship"        

        css_shipping.each do | name |
            shipping << name.text
        end
        shipping
    end
    def makeCpus(prices, names, shipping, desc_hash)
                                              
                                                            
        cpus = []                                                    
        prices.each_with_index do | price, index |         

            if !isCoolerOrMB?(names[index])                
                cpus << NeweggScraperChsbr::Cpu.new(names[index], price, shipping[index], desc_hash[index])      
                                                            
            end 
        end 
        cpus
    end
end
