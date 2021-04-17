
class NeweggScraperChsbr::CLI
    attr_reader :user
    def initialize
        NeweggScraperChsbr::DataGrabber.new
    end
    def call
        puts "Were you interested in purchasing some CPU's?"
        puts "Please enter y to do so."  
        @counter = gets.strip
        corr_input = control_bool
        while corr_input
            puts "Were you interested in purchasing some CPU's?"
            puts "Please enter y to do so.\nPlease enter n or exit to quit."  
            @counter = gets.strip
            corr_input = control_bool
        end
        while @counter == 'y'
            get_price_range
            get_init_data_for_user
            NeweggScraperChsbr::Cpu.display_cpu(@user)
            @user.choose_cpu
            NeweggScraperChsbr::Cpu.display_cpu_with_extras(@user)
            puts "If you would like to restart the program please enter : #{@counter}.\nTo exit type n or exit."
            @counter = gets.strip
            corr_input = control_bool
            while corr_input
                puts "Were you interested in purchasing some CPU's?"
                puts "Please enter y to do so.\nPlease enter n or exit to quit."  
                @counter = gets.strip
                corr_input = control_bool
            end
            
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
        if @counter.include?("y")
            false
        elsif @counter.include?("exit")
            false
        elsif @counter.include?("n") 
            false
        else
            true
        end
    end
    def cpu_make_bool
        if @cpu_make.include?("x")
            @cpu_make = "x"
            false
        elsif @cpu_make.include?("a")
            @cpu_make = "a"
            false
        elsif @cpu_make.include?("i")
            @cpu_make = "i"
            false
        else
            true
        end

    end
end