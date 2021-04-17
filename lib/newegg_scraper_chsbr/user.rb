
class NeweggScraperChsbr::User
    attr_accessor :cpu_make, :min_price, :max_price, :chosen_cpu
    def initialize(cpu_make = 'x', min_price = 0, max_price = 0)
        @cpu_make = cpu_make
        @min_price = min_price
        @max_price = max_price
        @chosen_cpu = []
    end
    def choose_cpu
        puts "Please enter the number of the CPU you'd like to see more about."
        chosen = gets.strip
        while !is_numeric?(chosen)
            puts "Please enter the number of the CPU you'd like to see more about."
            chosen = gets.strip
        end
        @chosen_cpu << chosen.to_i
        puts "Would you like to see more about another CPU?\nEnter y to do so.\nEnter n to see details about the chosen CPU(s)"
            input = gets.strip
            
        if input == 'y'
            choose_cpu
        end
        
    end
    def is_numeric?(obj) 
        obj.match(/\A[^+-]?\d+?(\^.\d+)?\Z/) == nil ? false : true
     end
end