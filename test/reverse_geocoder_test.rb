require 'bundler/setup'
require "test/unit"
require "shoulda/context"
require 'mongo'

require File.expand_path(File.dirname(__FILE__) + '/../lib/reverse_geocoder')

class ReverseGeocoderTest < Test::Unit::TestCase
  
  
  context  "reverse geocode lat/long coordinates" do
    setup do
      # @mongodb = Mongo::Connection.new("localhost").db("local_development")            
    end
    
    should "provide an address" do
      Geocoder::Configuration.timeout = 45
      # geocoder = ReverseGeocoder.new()
      ReverseGeocoder.perform("bhah")
      
    end
    
    teardown do
     # @mongodb[:locations].drop()
    end
  end
  
  
end