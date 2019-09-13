class Scraper

  BASE_URL = 'https://fortune.com'
  
  # Open first page of FORTUNE
  def self.first_page(year = nil)
    index_url = ""
    if year != nil
      index_url = BASE_URL + '/fortune500/' + year
    else 
      index_url = BASE_URL + '/fortune500/'
    end
    Nokogiri::HTML(open(index_url))
  end

  def self.scrape_year_index
    self.first_page.css('.yearNav__item--1tnHC a')
  end

  def self.get_top10_companies(input)
    self.first_page(input).css("li.teaserListItem__wrapper--3O03T a")
  end

  def self.scrape_companie_index(url)

  end

=begin
  def make_company(com_info_array)
    com_info_array.each do |r|
        WorldsBestRestaurants::Restaurant.new_from_index_page(r)
      end
  end
=end
end