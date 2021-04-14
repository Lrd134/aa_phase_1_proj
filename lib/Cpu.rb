require_relative '../config/environment.rb'
class Cpu
    attr_reader :name, :price, :price_was, :shipping
    @@all = []
    def initialize(name, price, priceWas, shipping)
        @name = CpuName.new(name)
        @price = Price.new(price)
        @price_was = priceWas
        @shipping = shipping
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
        @@all.each do | computer |
            
            if user.max_price.to_i == 0 && user.min_price.to_i == 0 && (Cpu.cpu_maker(user.cpu_make) == "Intel" || Cpu.cpu_maker(user.cpu_make) == "AMD")
                computer.name.name.include?(Cpu.cpu_maker(user.cpu_make)) ? puts("\n  #{counter}:\n     Name: #{computer.name.name}\n     Price: #{computer.price.price}") : nil
            elsif user.max_price.to_i == 0 && user.min_price.to_i == 0 && user.cpu_make == 'x'
                puts("\n  #{counter}:\n     Name: #{computer.name.name}\n     Price: #{computer.price.price}")
            elsif user.max_price.to_i >= computer.price.convert_price && user.min_price.to_i <= computer.price.convert_price && (Cpu.cpu_maker(user.cpu_make) == "Intel" || Cpu.cpu_maker(user.cpu_make) == "AMD")
                computer.name.name.include?(Cpu.cpu_maker(user.cpu_make)) ? puts("\n  #{counter}:\n     Name: #{computer.name.name}\n     Price: #{computer.price.price}") : nil
            
            elsif user.max_price.to_i >= computer.price.convert_price && user.min_price.to_i <= computer.price.convert_price && user.cpu_make == 'x'
                puts("\n  #{counter}:\n     Name: #{computer.name.name}\n     Price: #{computer.price.price}")
            end
            counter += 1
        end

    end
    def self.display_cpu_with_extras(user)
        binding.pry
        user.chosen_cpu.each do | chosen_cpu |
            @@all[user.chosen_cpu - 1] 

    end
end