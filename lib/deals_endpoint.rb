require 'bundler/setup'
require 'mongo'


class DealsEndpoint
  
  def initialize(mongodb)
    @mongodb = mongodb
  end

  def create_deal(lat, long, text)
    puts "inserting deal: #{text} at #{lat}/#{long}"
    object_id = @mongodb['locations'].insert({:latitude => lat, :longitude => long, :description => text, :created_at => Time.now  })
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
  
  conn =  Mongo::Connection.new("flame.mongohq.com", 27054).db("magnus")
  conn.authenticate("magnus", "magnus")
  
  deal = DealsEndpoint.new(conn)
  
  deal.create_deal(options[:latitude], options[:longitude], options[:deal])
  
end