class CLI

  attr_accessor :input_year

  def run
    puts "Welcome to the TOP 10 largest US corporations from Fortune magazine"

    scrape_years
    layer_years
  end

  def layer_years
    puts ""
    puts "What year ranking would you like to see between #{Year.all.last.year}-#{Year.all.first.year}?"
    @input_year = gets.strip

    if !(valid_year?(@input_year))
      puts "You entered an invalid value."
      #  recursion
      layer_years
    else
      # check if the year object exists
      # if yes, use it. if no, make a year object and scrape its companies
      layer_ranking(@input_year)
    end
  end

  def layer_ranking(input)
    y = Year.find_by_year(input)

    if y.companies.size == 0
      top_10 = Scraper.get_top10_companies(y)
      Company.new_from_index(top_10, input)
    end
    print_ranking(y)

    layer_company(y)
  end

  def layer_company(year)
    puts ""
    puts "What company would you like more information on? Enter the ranking of the company"
    puts "Or would you like to see another year ranking? Enter 'year'"
    puts "Or would you like to exit it? Enter exit"
    input = gets.strip.downcase

    if valid_rank?(input.to_i)
      print_company_info(year.companies[input.to_i - 1])
    elsif input == "year"

      layer_years
    elsif input == "exit"
      puts ""
      puts "Thank you!"
      exit
    else
      puts "You entered an invalid value. Enter a number from 1 to 10."
      # recursion
      layer_company
    end

    puts ""
    puts "Would you like to see another company? Enter Y"
    puts "Or would you like to see another year ranking? Enter 'year'"
    puts "Or would you like to exit it? Enter exit"
    input = gets.strip.downcase

    if input == "y"
      # recursion
      layer_ranking(@input_year)
    elsif input == "exit"
      puts ""
      puts "Thank you!"
      exit
    elsif input == "year"
      layer_years
    else
      puts ""
      puts "You entered an invalid value."
      layer_years
    end 
  end

  def valid_year?(input)
    if input =~ /[0-9][0-9][0-9][0-9]/ && !!(Year.all.detect{|x| x.year == input})
      return true
    else
      return false
    end

  end

  def valid_rank?(input)
    if input.between?(1, 10)
      return true
    else
      return false
    end
  end

  def scrape_years
    years = Scraper.scrape_year_index
    Year.new_from_index(years)
  end

  def print_ranking(input)
    puts "----------TOP 10 of #{input.year}------------"

    input.companies.each do |list|
      puts "#{list.rank}. #{list.name}"
    end

    puts "---------------------------------------------"
  end

  def print_company_info(com)
    if com.previous_rank == nil
      info_array = Scraper.scrape_companie_index(com.url)
      new_array = []
      info_array.collect do |x|
        x = x.downcase.split.join('_')
        if x.include?("market_value")
          new_array << x.byteslice(0, 12)
        else
          new_array << x.gsub(/\_\(\$m\)/, "")
        end
      end
      info_hash = Hash[*new_array]
      info_hash["detail"] = Scraper.scrape_company_detail(com.url)
      com.set_info(info_hash)
    end

    puts "-------------------------Company Info ------------------------"
    puts "Year Of Ranking           #{@input_year}"
    puts "Company:                  #{com.name}" if com.name != nil
    puts "Rank:                     #{com.rank}" if com.rank != nil
    puts "Previous Rank:            #{com.previous_rank}" if com.previous_rank != nil
    puts "CEO:                      #{com.ceo.gsub(/\_/, " ")}" if com.ceo != nil
    puts "address:                  #{com.address.gsub(/\_/, " ")}" if com.address != nil
    puts "Revenues($M):             #{com.revenues}" if com.revenues != nil
    puts "Revenue Percent Change:   #{com.revenue_percent_change}" if com.revenue_percent_change != nil
    puts "Market Value($M):         #{com.market_value}" if com.market_value != nil
    puts "Profits:                  #{com.profits}" if com.profits != nil
    puts "Profits Percent Change:   #{com.profits_percent_change}" if com.profits_percent_change != nil
    puts "Assets:                   #{com.assets}" if com.assets != nil
    puts "Employees:                #{com.employees}" if com.employees != nil
    puts "Website:                  #{com.website}" if com.website != nil
    puts "-------------------------Company Detail-----------------------" if com.detail != nil && com.detail != ""
    puts "#{com.detail}" if com.detail != nil && com.detail != ""
    puts "--------------------------------------------------------------"
  end
end