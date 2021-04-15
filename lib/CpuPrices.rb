require_relative '../config/environment.rb'
class CpuPrices
    attr_reader :cpus


    def initialize()
        shipping_price = getShipping
        prices = getPrice
        names = getNames
        getCpuDesc
        @cpus = makeCpus(prices, names, shipping_price)                     
    end #end initialize

    def getCpuDesc
        scraped = Scraper.new
        pages = []
        description = []
        css_next_link = scraped.xml_obj.css  ".item-title"
        css_next_link.each_with_index do | element, index |
            if index != 0
                pages << element.attributes["href"].value
            end
        end
        description = {}
        counter = 1
        pages.each_with_index do | url, index_of_pages |
            description[(index_of_pages)] = {}
            scraped_info = Scraper.new(url)
            descriptors = scraped_info.xml_obj.css(".product-bullets")
            descriptors.children.children.each do |info |
                info.children.each do | more_info |
                    
                    description[index_of_pages + 1][counter] = more_info.text
                    counter += 1
                    binding.pry
                end
                
            end
            counter = 0
            
        end
        description
        binding.pry


    end
    def split_price(html_element)               # This method checks each individual text element, this is to make sure the prices are accurate.
        counter = 0
        until counter == 100  
            if counter < 10                     # If the counter is less than 10, is necessary because the computer doesn't know we are working with money.
                if html_element.text.include?(".0#{counter.to_s}")  #If the text element includes any dollar ammount below .10 is a neccessary check.
                                                                    #Otherwise the computer would only check [.0.. .9], and we need it to check [.00.. .09]
                    price = html_element.text.split ".0#{counter.to_s}" #Once we know it's the correct element we can assign it to the price variable.
                                                                        #This is only necessary to be able to delete the data we are splitting off.
                                                                        # (We are splitting anything after the cents amount because it was uneccessary.)
                    price.delete_at 1
                    return price, ".0#{counter.to_s}"                   # Return the dollar amount, and the cents amount in an array.
                end
            elsif counter >= 10                                     # This does the same as above, but for any number over 9.
                if html_element.text.include?(".#{counter.to_s}") 

                    price = (html_element.text.split ".#{counter.to_s}")
                    price.delete_at 1 
                    return price, (".#{counter.to_s}")
                end
            end
        counter += 1
        end
    end
    def isCoolerOrMB?(name) # This methods name means is it a cooler or a motherboard?
        name.include?("Water") || name.include?("Air") || name.include?("Motherboard")  # this will return true if
                                                                                        # any of the products include
                                                                                        # words that describe motherboards and/or 
                                                                                        # cooling products.
    end
    def getPrice
        scraped_info = Scraper.new
        css_price = scraped_info.xml_obj.css ".price-current"    # This will set the variable equal to the
                                                            # html that contains what I need to find the price.

        prices = []                                         # This will hold all of the prices in an array.

        css_price.each do | piece |                         # Going 1 level deep into the html obj that contains the price text element.

            temp_price = split_price piece                  # split_price will split the price, and return
                                                            # two variables in an array. The first element of
                                                            # the array will be the dollar amount.
                                                            # The second element will be the cent ammount because
                                                            # I deemed it easier to remove anything after the
                                                            # floating point, it was the only pattern that was
                                                            # consistent.

            if temp_price != nil
                temp_price.flatten!                             # When returned by #split_price the dollar amount is
                                                                # nested inside of another array. I use flatten!
                                                                # to return the flattened array to temp_price.

                prices << "#{temp_price[0]}#{temp_price[1]}"    # Here prices is being shoveled the 
                                                                # two elements, concatenated to create
                                                                # a string similar to "$00.00"
            end

        end #end prices.each
        prices
    end
    def getNames
        scraped = Scraper.new
        names = []                                          # Names will hold the names of 
                                                            # objects found on the page.

        css_name = scraped.xml_obj.css ".item-title"        # css_name will hold the html 
                                                            # object to be enumerated upon.

        css_name.each_with_index do | name, index |         # css_name will be enumerated upon
                                                            # to retrieve the strings.

            index != 0 ? names << name.text : nil           # I have to skip the first name
                                                            # because it does not have a price.
                                                            # After I skip the first name
                                                            # I will shovel the text from the 
                                                            # html object into the names array.
        end #end names.each_with_index
        names
    end
    def getShipping
        scraped = Scraper.new
        shipping = []
        css_shipping = scraped.xml_obj.css ".price-ship"        

        css_shipping.each do | name |
            shipping << name.text
        end
        shipping
    end
    def makeCpus(prices, names, shipping)
                                              
                                                            
        cpus = []                                                    
        prices.each_with_index do | price, index |          # I will then enumerate on
                                                            # each of the prices with their
                                                            # index so that the enumation can
                                                            # access the names array at the
                                                            # same time.

            if !isCoolerOrMB?(names[index])                 # Here the program check if
                                                            # the name is a cooler
                                                            # or motherboard because
                                                            # there is a price associated
                                                            # with the coolers on the
                                                            # website.

                cpus << Cpu.new(names[index], price, shipping[index])      
                                                            
            end #end if
        end #end prices.each_with_index
        cpus
    end
end
