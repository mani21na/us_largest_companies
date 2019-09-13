class CLI

  def run
    puts "Welcome to the TOP 10 largest US corporations from Fortune magazine"
    puts ""
    
    call
  end

  def call
    puts "What year ranking would you like to see between #{print_years.last}-#{print_years.first}?"
    input = gets.strip
 
    print_companies(input)
    puts ""
    puts "What company would you like more information on?\n***Please type the rank of the company***"
    input = gets.strip

    print_company_info(input)
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
      #list[:url] = company['href']
      top_10 << list
    end
 
    puts "THE TOP 10"
 
    top_10.each do |list|
      puts "#{list[:rank]}. #{list[:name]}"
    end

    Companies.new_from_index(top_10)
  end

  def print_company_info(input)
    Companies.all
  end
end