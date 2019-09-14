class CLI

  def run
    puts "Welcome to the TOP 10 largest US corporations from Fortune magazine"
    puts ""
    
    call
  end

  def call
    puts "What year ranking would you like to see between #{print_years.last}-#{print_years.first}?"
    input = gets.strip

    if valid_year?(input)
      print_companies(input)
    else
      puts "You inputted an invalid year. Please input a valid year from #{print_years.last} to #{print_years.first}."
      exit
    end

    puts ""
    puts "What company would you like more information on?\n***Please type the rank of the company***"    
    input = gets.strip

    if valid_rank?(input.to_i)
      print_company_info(input)
    else
      puts "You inputted an invalid rank. Please input a rank form 1 to 10."
      Companies.all_delete
      exit
    end

    puts ""
    puts "Would you like to see another restaurant? Enter Y or N"
    input = gets.strip.downcase
    if input == "y"
      Companies.all_delete
      call
    elsif input == "n"
      puts ""
      puts "Thank you!"
      Companies.all_delete
      exit
    else
      puts ""
      puts "I don't understand that answer."
      Companies.all_delete
      call
    end 
  end

  def valid_year?(input)
    if input =~ /[0-9][0-9][0-9][0-9]/ && print_years.include?(input)
      return true
    else
      return false
    end
  end

  def valid_rank?(input)
    if input.between?(1,10)
      return true
    else
      return false
    end
  end

  def print_years
    years = []
    Scraper.scrape_year_index.each do |year|
      years << year.text
    end
    years
  end

  def print_companies(input)
    top_10 = []
    Scraper.get_top10_companies(input).each do |company|
      list = {}
      list[:rank] = company.css("span")[0].text
      list[:name] = company.css("span")[1].text
      list[:url] = company['href']
      list[:year] = input
      top_10 << list
    end
 
    puts "----------TOP 10------------"

    top_10.each do |list|
      puts "#{list[:rank]}. #{list[:name]}"
    end

    puts "----------------------------"

    Companies.new_from_index(top_10)
  end

  def print_company_info(input)
    com = Companies.all.detect{|com| com.url if com.rank == input}
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

    puts "------------Company Info:#{com.year}-------------"
    puts "Company:                  #{com.name}" if com.name != nil
    puts "Rank:                     #{com.rank}" if com.rank != nil
    puts "Previous Rank:            #{com.previous_rank}" if com.previous_rank != nil
    puts "CEO:                      #{com.ceo.gsub(/\_/, " ")}" if com.ceo != nil
    puts "address:                  #{com.address.gsub(/\_/, " ")}" if com.address != nil
    puts "Revenues:                 #{com.revenues}" if com.revenues != nil
    puts "Revenue Percent Change:   #{com.revenue_percent_change}" if com.revenue_percent_change != nil
    puts "Market Value:             #{com.market_value}" if com.market_value != nil
    puts "Profits:                  #{com.profits}" if com.profits != nil
    puts "Profits Percent Change:   #{com.profits_percent_change}" if com.profits_percent_change != nil
    puts "Assets:                   #{com.assets}" if com.assets != nil
    puts "Employees:                #{com.employees}" if com.employees != nil
    puts "Website:                  #{com.website}" if com.website != nil
    puts "-------------Company Detail----------------------" if com.detail != "" && nil

    puts "#{com.detail}" if com.detail != nil && ""
    puts "--------------------------------------------------"
  end
end