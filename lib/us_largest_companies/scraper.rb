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
    puts "call scraper of year!"
    years = []
    first_page.css('.yearNav__item--1tnHC a').each do |year|
      years << year.text
    end
    years
  end

  def self.get_top10_companies(input)
    puts "call scraper of top 10!"
    top_10 = []
    first_page(input.year).css("li.teaserListItem__wrapper--3O03T a").each do |company|
      list = {}
      list[:rank] = company.css("span")[0].text
      list[:name] = company.css("span")[1].text
      list[:url] = company['href']
      top_10 << list
    end
    top_10
  end

  def self.scrape_companie_index(url)
    puts "call scraper of company index!"
    com_info = Nokogiri::HTML(open(url))
    info_array = []
    com_info.css("div.highlightedStats__wrapper--VuLob span").each do |info|
      info_array << info.text
    end
    info_array
  end

  def self.scrape_company_detail(url)
    com_detail = Nokogiri::HTML(open(url))
    com_detail.css("div.singleDescription__wrapper--3gwtb p").text
  end
end