
class NeweggScraperChsbr::Cpu
    attr_reader :name, :price, :desc, :shipping
    @@all = []
    def initialize(name, price, shipping, desc)
        @name = NeweggScraperChsbr::Name.new(name)
        @price = NeweggScraperChsbr::Price.new(price)
        @desc = NeweggScraperChsbr::Descriptors.new(desc)
        @shipping = NeweggScraperChsbr::Shipping.new(shipping)
        @@all << self
    end
    def self.all
        @@all
    end
    def self.cpu_maker(cpu_make)
        if cpu_make == 'i'
            "Intel"
        elsif cpu_make == 'a'
            "AMD"
        else
            "either Intel or AMD"
        end
    end
    def self.display_cpu(user) 
        counter = 1
        printed_cpus = []
        @@all.each do | computer |
            if user.max_price.to_i != 0 && user.min_price.to_i == 0
                

                user.min_price = "1"
            end
            if user.max_price.to_i == 0 &&
                user.min_price.to_i == 0 &&
                (NeweggScraperChsbr::Cpu.cpu_maker(user.cpu_make) == "Intel" || NeweggScraperChsbr::Cpu.cpu_maker(user.cpu_make) == "AMD")
                    if computer.name.name.include?(NeweggScraperChsbr::Cpu.cpu_maker(user.cpu_make))
                        puts("\n  #{counter}:\n     Name: #{computer.name.name}\n     Price: #{computer.price.price}")
                        printed_cpus << counter
                    else
                        nil
                    end
            elsif user.max_price.to_i == 0 && user.min_price.to_i == 0 && user.cpu_make == 'x'
                    
                    puts("\n   #{counter}:\n     Name: #{computer.name.name}\n     Price: #{computer.price.price}")
                    printed_cpus << counter
            elsif user.max_price.to_i >= computer.price.convert_price &&
                user.min_price.to_i <= computer.price.convert_price &&
                (NeweggScraperChsbr::Cpu.cpu_maker(user.cpu_make) == "Intel" || NeweggScraperChsbr::Cpu.cpu_maker(user.cpu_make) == "AMD")
                    if computer.name.name.include?(NeweggScraperChsbr::Cpu.cpu_maker(user.cpu_make)) 
                        puts("\n  #{counter}:\n     Name: #{computer.name.name}\n     Price: #{computer.price.price}")
                        printed_cpus << counter
                    else
                        nil
                    end
            
            elsif user.max_price.to_i >= computer.price.convert_price &&
                user.min_price.to_i <= computer.price.convert_price &&
                user.cpu_make == 'x'
                    puts("\n  #{counter}:\n     Name: #{computer.name.name}\n     Price: #{computer.price.price}")
                    printed_cpus << counter

            elsif printed_cpus.size == 0
                puts "You did not match any CPU criteria."
            end

            counter += 1
            
        end
        printed_cpus

    end
    def self.display_cpu_with_extras(user)
        
        user.chosen_cpu.each do | chosen_cpu |
            puts "\n\n\n#{@@all[chosen_cpu - 1].name.name}\nHas a price of: #{@@all[chosen_cpu - 1].price.price}\nShipping: #{@@all[chosen_cpu - 1].shipping.price}\n\n   Descriptive Points:\n"
            @@all[chosen_cpu - 1].printDesc
        end
    end
    def printDesc
        @desc.bullets.each do | key, value |
            puts "          #{key + 1}: #{value}"
        end
    end

end