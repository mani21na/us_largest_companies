require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative 'us_largest_companies/version'
require_relative 'us_largest_companies/cli'
require_relative 'us_largest_companies/scraper'
require_relative 'us_largest_companies/company'
require_relative 'us_largest_companies/year'

module UsLargestCompanies
  class Error < StandardError; end
  # Your code goes here...
end
