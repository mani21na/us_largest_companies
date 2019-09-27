class Company
  
  attr_accessor :name, :previous_rank, :ceo, :rank, :profits, :assets,
                :url, :employees, :revenues, :website, :address, :revenue_percent_change, 
                :profits_percent_change, :market_value, :detail, :morning_consult_brand_index
  
  @@all = []

  def initialize(attributes)
    attributes.each{|key, value| self.send(("#{key}="), value)}
    @@all << self
  end
  
  def self.new_from_index(attributes_array, year)
    y = Year.find_by_year(year)
    attributes_array.each{|company| y.companies << self.new(company)}
  end

  def set_info(attributes_hash)
     attributes_hash.each{|key, value| self.send(("#{key}="), value)}
  end

  def self.all
    @@all
  end
end