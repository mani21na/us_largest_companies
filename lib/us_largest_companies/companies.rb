class Companies
  
  attr_accessor :year, :name, :position, :ceo, :ceo_title, :industry, :hq_location, :website, :employees, :revenues
  
  @@all = []

  def initialize
          
  end

  def self.all
    @@all
  end

  
end