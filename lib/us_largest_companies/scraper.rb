class Scraper

  BASE_URL = 'https://fortune.com'
  
  #Open first page of FORTUNE 500
  def self.get_page
    index_url = BASE_URL + '/fortune500/'
 
    #return value
    Nokogiri::HTML(open(index_url))
  end

  def self.scrape_year_index
    years = []
    self.get_page.css('.yearNav__item--1tnHC').each do |year|
      years << year.css('a').text
    end
    years
    binding.pry
  end

end