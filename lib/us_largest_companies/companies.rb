class Companies
  
  attr_accessor :year, :name, :position, :ceo, :rank, :industry, :hq_location, :url, :employees, :revenues
  
  @@all = []

  def initialize(attributes)
    attributes.each{|key, value| self.send(("#{key}="), value)}
    @@all << self
  end
  
  def self.new_from_index(attributes_array)
    attributes_array.each{|company| self.new(company)}
    binding.pry
  end

  def self.all
    @@all
  end
end