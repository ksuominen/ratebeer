class BeermappingApi
  def self.places_in(city)
    city = city.downcase
    
    places = Rails.cache.read(city)
    return places if places
    
    places = get_places_in(city)
    Rails.cache.write(city, places, expires_in: 7.days)
    places
  end
  
  def self.get_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"
  
    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]
  
    return [] if places.is_a?(Hash) and places['id'].nil?
  
    places = [places] if places.is_a?(Hash)
    places.map do | place |
      Place.new(place)
    end
  end
  
  def self.key
    "c924d5f59e963d7de3050f8d2fb34220"
  end
end