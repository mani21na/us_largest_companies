class CLI

  def run

    puts 'Welcome, this is the rank of the largest US corporations from Fortune magazine'
    puts ''
    puts 'Please, select the year of the rank'
    
    Scraper.scrape_year_index
  end


  def print_years_of_rank
    
  end


end