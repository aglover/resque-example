require "geocoder"
require "mongo"

class ReverseGeocoder
  
  @queue = "reverse_geocode"

  def self.perform(document_id)
    Geocoder::Configuration.timeout = 45
    doc = connection[:locations].find({:_id => BSON::ObjectId.from_string(document_id)}).first
    result = Geocoder.address([doc['latitude'], doc['longitude']])
    connection[:locations].update({ :_id => BSON::ObjectId.from_string(document_id) }, {'$set' => { :address => result } } )   
  end

  def self.connection
    conn =  Mongo::Connection.new("flame.mongohq.com", 27054).db("magnus")
    conn.authenticate("magnus", "magnus")
    return conn
  end

end