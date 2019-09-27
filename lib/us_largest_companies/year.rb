class Year
  attr_accessor :year, :companies

  @@all = []

  def initialize(year)
    @year = year
    @companies =[]
    @@all << self
  end

  def self.new_from_index(years_array)
    years_array.each{|year| self.new(year)}
  end

  def self.all
    @@all
  end

  def self.find_by_year(year)
    @@all.detect{|x| x.year == year}
  end
end
