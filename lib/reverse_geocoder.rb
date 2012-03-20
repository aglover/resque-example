require "geocoder"


class ReverseGeocoder
  
  @queue = "reverse_geocode"

  def self.perform(document_id)
    results = Geocoder.address([39.1155556, -77.5638889])
    puts "result are? #{results}"
  end

end