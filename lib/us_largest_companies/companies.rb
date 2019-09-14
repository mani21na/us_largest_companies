class Companies
  
  attr_accessor :year, :name, :previous_rank, :ceo, :rank, :profits, :assets, 
                :url, :employees, :revenues, :website, :address, :revenue_percent_change, 
                :profits_percent_change, :market_value, :detail
  
  @@all = []

  def initialize(attributes)
    attributes.each{|key, value| self.send(("#{key}="), value)}
    @@all << self
  end
  
  def self.new_from_index(attributes_array)
    attributes_array.each{|company| self.new(company)}
  end

  def set_info(attributes_hash)
    attributes_hash.each{|key, value| self.send(("#{key}="), value)}
    #binding.pry
  end
  
  def self.all
    @@all
  end

  def self.all_delete
    @@all.clear
  end
end