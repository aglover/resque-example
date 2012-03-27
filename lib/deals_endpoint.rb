require 'bundler/setup'
require 'mongo'
require 'resque'
require File.expand_path(File.dirname(__FILE__) + '/reverse_geocoder') 


# Latitude: 39.1155556
# Longitude: -77.5638889

class DealsEndpoint
  
  def initialize(mongodb)
    @mongodb = mongodb
  end

  def create_deal(lat, long, text)
    object_id = @mongodb['locations'].insert({:latitude => lat.to_f, :longitude => long.to_f, :description => text, :created_at => Time.now  })
    Resque.enqueue(ReverseGeocoder, object_id.to_s)
    return object_id
  end 
  
end



if __FILE__ == $0
  
  options = {}
  OptionParser.new do |opts|
    opts.on("-a", "--latitude LAT", "latitude") do |t|
      options[:latitude] = t
    end
    opts.on("-b", "--longitude LONG", "longitude") do |t|
      options[:longitude] = t
    end
    opts.on("-d", "--deal DEAL", "deal") do |t|
      options[:deal] = t
    end
  end.parse!
  

  raise "You must provide all options" if (options[:latitude].nil? || options[:longitude].nil? || options[:deal].nil?)
  
  Resque.redis = 'redis://aglover:f92102d2d01e71cf33b3dd14de89d282@cod.redistogo.com:9910/'
  
  conn =  Mongo::Connection.new("flame.mongohq.com", 27054).db("magnus")
  conn.authenticate("magnus", "magnus")
  deal = DealsEndpoint.new(conn)
  
  deal.create_deal(options[:latitude], options[:longitude], options[:deal])
  
end