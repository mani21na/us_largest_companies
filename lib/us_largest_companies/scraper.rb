class Scraper

  BASE_URL = 'https://fortune.com'
  
  # Open first page of FORTUNE
  def first_page(year = nil)
    index_url = ""
    if year != nil
      index_url = BASE_URL + '/fortune500/' + year
    else 
      index_url = BASE_URL + '/fortune500/'
    end
    Nokogiri::HTML(open(index_url))
  end

  def scrape_year_index
    first_page.css('.yearNav__item--1tnHC a')
  end

  def get_top10_companies(input)
    first_page(input).css("li.teaserListItem__wrapper--3O03T a")
  end

  def scrape_companie_index(url)
    com_info = Nokogiri::HTML(open(url))
    info_array = []
    com_info.css("div.highlightedStats__wrapper--VuLob span").each do |info|
      info_array << info.text
    end
    info_array
  end

  def scrape_company_detail(url)
    com_detail = Nokogiri::HTML(open(url))
    com_detail.css("div.singleDescription__wrapper--3gwtb p").text
  end
end