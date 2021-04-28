class NeweggScraperChsbr::Cli
    attr_reader :user
    def initialize
        NeweggScraperChsbr::DataGrabber.new
    end
    def call
        puts "Were you interested in purchasing some CPU's?"
        puts "Please enter y to do so."  
        @counter = gets.strip
        incorrect_input = control_bool
        while incorrect_input
            puts "Were you interested in purchasing some CPU's?"
            puts "Please enter y to do so.\nPlease enter n or exit to quit."  
            @counter = gets.strip
            incorrect_input = control_bool
        end
        while @counter == 'y'
            get_price_range
            get_init_data_for_user
            printed_cpus = NeweggScraperChsbr::Cpu.display_cpu(@user)

            if printed_cpus.size != 0
                @user.choose_cpu(printed_cpus)
                NeweggScraperChsbr::Cpu.display_cpu_with_extras(@user)
            end
    
            
            
            puts "If you would like to restart the program please enter : #{@counter}.\nTo exit type n or exit."
            @counter = gets.strip
            incorrect = control_bool
            while incorrect
                puts "Were you interested in purchasing some CPU's?"
                puts "Please enter y to do so.\nPlease enter n or exit to quit."  
                @counter = gets.strip
                incorrect = control_bool
            end
            clear_vars
            @user.clear_chosen
            self.call    
        end
        puts "Thanks for using Chesbro's Scraper!"
    end
    def get_init_data_for_user
        
        if @counter == 'y'
            
            puts "Are you searching for Intel or AMD?"
            puts "Please put i for Intel, or a for AMD."
            puts "Please put x for either."
            @cpu_make = gets.strip
            not_found = cpu_make_bool
            while not_found
                puts "Are you searching for Intel or AMD?"
                puts "Please put i for Intel, or a for AMD."
                puts "Please put x for either."
                @cpu_make = gets.strip
                not_found = cpu_make_bool
            end
            puts "\n\nYou want to search for (an) #{NeweggScraperChsbr::Cpu.cpu_maker(@cpu_make)} CPU."
            if @max_price.to_i != 0 && @min_price.to_i != 0
                puts "You entered a maximum price of $#{@max_price}, and a minimum price of $#{@min_price}."
            elsif @max_price.to_i != 0
                puts "You entered a maximum price of $#{@max_price}."
            else
                puts "You did not set a price to search for."
            end
            if_correct_info


        end
    end
    def if_correct_info
        puts "\nIf you're satisfied with your selection, the computer will print\na list of CPUs that satisfy the criteria. Enter y to continue. Enter n to choose again."
        @counter = gets.strip
        if @counter == 'y'
            @user = NeweggScraperChsbr::User.new(@cpu_make, @min_price, @max_price)
        else
            @counter = 'y'
            call
        end
    end
    def get_price_range
        puts "Welcome. Would you like to set a budget? If no, set your maximum budget to 0"
        puts "Please enter the integer value of your maximum price."
        puts "$500.50, please enter as 501, or 500 to stay below budget."        
        @max_price = gets.strip
        while @max_price.to_i < 0 || @max_price.to_i > 10000 || @max_price.include?("$") || @max_price.include?(".") || @max_price == nil
            puts "Welcome. Would you like to set a budget? If no, set your maximum budget to 0"
            puts "Please enter the integer value of your maximum price."
            puts "$500.50, please enter as 501, or 500 to stay below budget."        
            @max_price = gets.strip
        end
        if @max_price.to_i != 0
            puts "Please enter the minimum you would spend on a CPU."
            puts "Please use the same format as above."
            @min_price = gets.strip
            
            while @min_price.to_i <= 0  || @min_price.to_i >= @max_price.to_i || @min_price.include?("$") || @min_price.include?(".") || @min_price == nil
                puts "Please enter the minimum you would spend on a CPU."
                puts "Please use the same format as above."
                @min_price = gets.strip
            end
        end
    end
    def control_bool
        if @counter == "y"
            false
        elsif @counter == "exit" || @counter == "n" 
            false
        else
            true
        end
    end
    def cpu_make_bool
        if @cpu_make == "x" || @cpu_make == "a" || @cpu_make == "i"
            false
        else
            true
        end

    end
    def clear_vars
        @cpu_make = nil
        @min_price = nil
        @max_price = nil
    end
        # def choose_cpu(printed_cpus)
    #     puts "Please enter the number of the CPU you'd like to see more about."
    #     chosen = gets.strip
    #     while !is_numeric?(chosen)
    #         puts "Please enter the number of the CPU you'd like to see more about."
    #         chosen = gets.strip
    #     end
    #     if !printed_cpus.include?(chosen.to_i)
    #         puts "You chose a CPU outside of your budget please choose another."
    #         choose_cpu(printed_cpus)
    #     end
    #     @user.chosen_cpu << chosen.to_i
    #     puts "Would you like to see more about another CPU?\nEnter y to do so.\nEnter n to see details about the chosen CPU(s)"
    #         input = gets.strip
            
    #     if input == 'y'
    #         choose_cpu(printed_cpus)
    #     end
        
    # end
    # def is_numeric?(obj) 
    #     obj.match(/\A[^+-]?\d+?(\^.\d+)?\Z/) == nil ? false : true
    #  end
    #  def self.display_cpu_with_extras(user)
        
    #     user.chosen_cpu.each do | chosen_cpu |

    #         puts "\n\n\n#{NeweggScraperChsbr::Cpu.all[chosen_cpu - 1].name.name}\nHas a price of: #{NeweggScraperChsbr::Cpu.all[chosen_cpu - 1].price.price}\nShipping: #{NeweggScraperChsbr::Cpu.all[chosen_cpu - 1].shipping.price}\n\n   Descriptive Points:\n"
    #         NeweggScraperChsbr::Cpu.all[chosen_cpu - 1].printDesc
    #     end
    # end
end