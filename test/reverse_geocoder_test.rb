require "bundler/setup"
require "test/unit"
require "shoulda/context"
require "mongo"
require "mocha"
require File.expand_path(File.dirname(__FILE__) + '/../lib/reverse_geocoder')

class ReverseGeocoderTest < Test::Unit::TestCase
  
  
  context  "reverse geocode lat/long coordinates" do
    setup do
      @mongodb = Mongo::Connection.new("localhost").db("local_development") 
      ReverseGeocoder.expects(:connection).at_least(2).returns(@mongodb)
      
      @object_id = @mongodb['locations'].insert({:latitude => 39.115555, :longitude => -77.5638889, 
        :description => "Free Beer!", :created_at => Time.now })
        
      Geocoder.expects(:address).with(any_parameters).returns("36 Virginia 7 Business, Leesburg, VA 20175, USA")
    end
    
    should "provide an address" do
      ReverseGeocoder.perform(@object_id.to_s)
      doc = @mongodb[:locations].find({:_id => @object_id}).first
      assert_equal "36 Virginia 7 Business, Leesburg, VA 20175, USA", doc['address'], "address was really #{doc['address']}"
    end
    
    teardown do
     @mongodb[:locations].drop()
    end
  end
  
  
end