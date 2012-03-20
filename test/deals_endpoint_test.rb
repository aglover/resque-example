require 'bundler/setup'
require "test/unit"
require "shoulda/context"
require 'mongo'

require File.expand_path(File.dirname(__FILE__) + '/../lib/deals_endpoint')

class DealsEndpointTest < Test::Unit::TestCase
  
  
  context  "DealsEndpoint should insert documents into a locations collection" do
    setup do
      @mongodb = Mongo::Connection.new("localhost").db("local_development")            
    end
    
    should "contain a document with 3 attributes" do
      
      endpoint = DealsEndpoint.new(@mongodb)
      id = endpoint.create_deal(39.6, 77.33, "Free Beer!!")
      
      doc = @mongodb[:locations].find({:_id => id}).first
      
      assert_equal 39.6, doc['latitude'], "latitude was really #{doc['latitude']}"
      assert_equal 77.33, doc['longitude'], "longitude was really #{doc['longitude']}"
      assert_equal "Free Beer!!", doc['description'], "description was really #{doc['description']}"
      
    end
    
    teardown do
     @mongodb[:locations].drop()
    end
  end
  
  
end